"""
A kitten for saving kitty sessions.

## Usage

Open kitty repl (ctrl+shift+esc), then run:
$ kitten save_session.py <name>
"""
import argparse
import json
import os
from pathlib import Path
import shlex
import subprocess
from typing import Optional

from kitty.boss import Boss
from kitty.child import parse_environ_block
from kitty.constants import config_dir as KITTY_CONF_DIR, kitty_exe
from kittens.tui.handler import result_handler
from kitty.window import WindowDict


class Arguments(argparse.Namespace):
    debug: bool
    use_fg: bool
    file: Path


class ArgumentParser(argparse.ArgumentParser):
    def exit(self, status: int = 0, message: Optional[str] = None):
        """
        Prevents stdlib's argument parser killing the process
        """
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
    session_file = get_session_file(sessions_dir, args.file)

    data = serialize_session(boss, args.use_fg)
    with open(session_file, 'w') as fp:
        fp.write(data)


def parse_args(argv: list[str]) -> Arguments:
    parser = ArgumentParser(exit_on_error=False)
    parser.add_argument(
        '-d',
        '--debug',
        action='store_true',
        help='Dumps session as json into session dir.',
    )
    parser.add_argument('-p', dest='use_fg', action='store_true', help='Save foreground processes.')
    parser.add_argument('file', nargs='?', type=Path, default='last-session.conf')

    return parser.parse_args(argv, namespace=Arguments())


def get_session_file(session_dir: Path, path: Path) -> Path:
    session_file = path.expanduser()
    if not session_file.suffix:
        session_file = session_file.with_suffix('.conf')
    return session_dir.joinpath(session_file)


def dump_session(boss: Boss, path):
    with open(path, 'w') as fp:
        data = list(boss.list_os_windows())
        json.dump(data, fp, indent=2)


def serialize_session(boss: Boss, use_fg=False) -> str:
    lines = []
    for i, os_win in enumerate(boss.list_os_windows()):
        if i > 0:
            lines.extend(['', 'new_os_window'])
        for j, tab in enumerate(os_win['tabs']):
            if j > 0:
                lines.append('')
            lines.extend(
                [
                    f'new_tab {tab["title"]}',
                    f'layout {tab["layout"]}',
                ]
            )
            windows = (w for w in tab['windows'] if not should_skip_window(w))
            for win in windows:
                if should_skip_window(win):
                    continue
                args = get_launch_args(win, use_fg)
                lines.extend(
                    [
                        f'title {win["title"]}',
                        f'cd {win["cwd"]}',
                        shlex.join(('launch', *args)),
                    ]
                )
                if win['is_focused']:
                    lines.append('focus')
    return '\n'.join(lines)


def should_skip_window(win: WindowDict) -> bool:
    return kitty_exe() in (
        win['cmdline'][0],
        win['foreground_processes'][0]['cmdline'][0],
    )


def get_launch_args(win: WindowDict, use_fg: bool) -> list[str]:
    """
    Convert a foreground_processes list to a space separated string.

    Currently we have no way to fetch the user's last entered command,
    so we have to do guesswork for when /proc/<pid>/cmdline is not the
    original command (i.e. a wrapper script calling exec, an appimage, flatpak app...)
    """
    proc = win['foreground_processes'][0]
    if not use_fg or proc['cmdline'] == win['cmdline']:
        return win['cmdline']
    # we have a foreground process that's not the shell itself
    pid, cmd = proc['pid'], proc['cmdline']
    env = get_process_env(pid)
    if appimage := env.get('APPIMAGE'):
        # this is an appimage mountpoint, the real executable is $APPIMAGE
        return [appimage, *cmd[1:]]
    match cmd:
        case ['bwrap', '--args', fd, ns, *args]:
            # looks like a flatpak app?
            if result := get_flatpak_cmd(pid, args):
                return result
            return cmd
        case _:
            return cmd


def get_process_env(pid: int) -> dict[str, str]:
    with open(f'/proc/{pid}/environ', 'r') as fp:
        return parse_environ_block(fp.read())


def get_flatpak_cmd(cmd_pid: int, args: list[str]) -> Optional[list[str]]:
    needle = str(cmd_pid)
    cmd = ('flatpak', 'ps', '--columns=pid,child-pid,application')
    proc = subprocess.run(cmd, capture_output=True, encoding='utf-8')
    for line in proc.stdout.splitlines():
        pid, cid, appid = line.split()
        if needle in (pid, cid):
            return ['flatpak', 'run', appid, *args]
    return None


def env_to_opts(env) -> str:
    """
    Converts an env dict to a series of '--env key=value' parameters and return as a string.
    """
    return ' '.join(f'--env {k}={v}' for k, v in env.items())
