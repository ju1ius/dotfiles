'''
A kitten for saving kitty sessions.
'''
import argparse
import json
import os
from pathlib import Path
import shlex
import subprocess
from typing import Optional

from kitty.boss import Boss
from kitty.child import parse_environ_block
from kitty.constants import config_dir as KITTY_CONF_DIR
from kittens.tui.handler import result_handler
from kitty.window import WindowDict


class Arguments(argparse.Namespace):
    debug: bool
    file: Path
    

class ArgumentParser(argparse.ArgumentParser):
    def exit(self, status: int = 0, message: Optional[str] = None):
        '''
        Prevents stdlib's argument parser killing the process
        '''
        if status:
            raise RuntimeError(status, message) 


def main(args: list[str]) -> Optional[str]:
    ...


@result_handler(no_ui=True)
def handle_result(argv: list[str], answer: str, target_window_id: int, boss: Boss) -> None:
    sessions_dir = Path(KITTY_CONF_DIR) / 'sessions'
    os.makedirs(sessions_dir, exist_ok=True)

    args = parse_args(argv[1:])
    if args.debug:
        dump_session(boss, sessions_dir / 'session-dump.json')
    session_file = sessions_dir.joinpath(args.file.expanduser())

    data = serialize_session(boss)
    with open(session_file, 'w') as fp:
        fp.write(data)


def parse_args(argv: list[str]) -> Arguments:
    parser = ArgumentParser(exit_on_error=False)
    parser.add_argument('-d', '--debug', action='store_true')
    parser.add_argument('file', nargs='?', type=Path, default='last-session.conf')
    
    return parser.parse_args(argv, namespace=Arguments())


def dump_session(boss: Boss, path):
    with open(path, 'w') as fp:
        data = list(boss.list_os_windows())
        json.dump(data, fp, indent=2)


def serialize_session(boss: Boss) -> str:
    lines = []
    for i, os_win in enumerate(boss.list_os_windows()):
        if i > 0:
            lines.extend(['', 'new_os_window'])
        for j, tab in enumerate(os_win['tabs']):
            if j > 0:
                lines.append('')
            lines.extend([
                f'new_tab {tab["title"]}',
                f'layout {tab["layout"]}',
            ])
            if tab['windows']:
                cwd = tab['windows'][0]['cwd']
                lines.append(shlex.join(('cd', cwd)))
            for win in tab['windows']:
                args = get_launch_args(win, boss)
                lines.extend([
                    f'title {win["title"]}',
                    shlex.join(('launch', *args)),
                ])
                if win['is_focused']:
                    lines.append('focus')
    return "\n".join(lines)


def get_launch_args(win: WindowDict, boss: Boss) -> list[str]:
    '''
    Convert a foreground_processes list to a space separated string.
    '''
    proc = win['foreground_processes'][0]
    pid, cmd = proc['pid'], proc['cmdline']
    env = get_process_env(pid)
    if appimage := env.get('APPIMAGE'):
        # this is an appimage mountpoint, the real executable is $APPIMAGE
        return [appimage, *cmd[1:]]
    if cmd[0] == 'bwrap':
        # looks like a flatpak'ed app:
        # cmd = ['bwrap', '--args', '42', 'foo', ...args]
        return get_flatpak_cmd(pid, cmd[4:])
    return cmd



def get_process_env(pid: int) -> dict[str, str]:
    with open(f'/proc/{pid}/environ', 'r') as fp:
        return parse_environ_block(fp.read())
    

def get_flatpak_cmd(cmd_pid: int, args: list[str]) -> list[str]:
    needle = str(cmd_pid)
    cmd = ('flatpak', 'ps', '--columns=pid,child-pid,application')
    proc = subprocess.run(cmd, capture_output=True, encoding='utf-8')
    for line in proc.stdout.splitlines():
        pid, cid, appid = line.split()
        if needle in (pid, cid):
            return ['flatpak', 'run', appid, *args]
    raise RuntimeError(
        'Could not find appid of flatpak process: '
        f'{needle} not found in: {proc.stdout}'
    )


def env_to_opts(env) -> str:
    '''
    Converts an env dict to a series of '--env key=value' parameters and return as a string.
    '''
    return " ".join(f'--env {k}={v}' for k, v in env.items())
