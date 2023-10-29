"""
write_mark(chars):
  0x1b]133; (chars) 0x1b\\
prompt_start(): write_mark('A')
ps2_start(): write_mark('A;k=s')
output_start(): write_mark('C')
"""
import itertools
import json
import os
from pathlib import Path
import re
import shlex
import subprocess
from typing import Any, Optional

from kitty.boss import Boss
from kitty.child import parse_environ_block
from kitty.constants import config_dir as KITTY_CONF_DIR, kitty_exe
from kittens.tui.handler import result_handler
from kitty.window import Window, WindowDict
from kitty.fast_data_types import Screen


def main(args: list[str]) -> Optional[str]:
    ...


@result_handler(no_ui=True)
def handle_result(
    argv: list[str], answer: str, target_window_id: int, boss: Boss
) -> None:
    sessions_dir = Path(KITTY_CONF_DIR) / "sessions"
    os.makedirs(sessions_dir, exist_ok=True)

    session_file = sessions_dir / "debug.json"

    data = serialize_session(boss)
    with open(session_file, "w") as fp:
        json.dump(data, fp, indent=2)


def serialize_session(boss: Boss) -> list[Any]:
    data: list[Any] = []
    for w in iter_windows(boss):
        win: Window = boss.window_id_map[w["id"]]
        buf = win.as_text(as_ansi=True)
        # data.append(buf)
        for chunk in parse_screen_buffer(buf):
            data.append(chunk)
        # screen: Screen = win.screen
        # data.append(screen.linebuf)
    return data


def iter_windows(boss: Boss):
    for osw in boss.list_os_windows():
        for tab in osw["tabs"]:
            for win in tab["windows"]:
                yield win


def parse_screen_buffer(buf: str):
    # prompt_start_mark = '\x1b\x5d133;A\x1b\x5c'
    # output_start_mark = '\x1b\x5d133;C\x1b\x5c'
    remarks = re.compile(r"\x1b\x5d133;([AC])\x1b\x5c")
    marks: list[tuple[str, int]] = []
    for m in remarks.finditer(buf):
        ty = m.group(1)
        marks.append((ty, m.end() if ty == "A" else m.start()))
    for (st, sp), (et, ep) in pairwise(marks):
        if st == "C":
            continue
        yield buf[sp:ep]


def pairwise(iterable):
    a, b = itertools.tee(iterable)
    next(b, None)
    return zip(a, b)
