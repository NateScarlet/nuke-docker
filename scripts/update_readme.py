#!/usr/bin/env python
"""Update readme by data. """
from itertools import chain
from pathlib import Path

from update_versions import load_versions


def _get_badges_lines():
    for i in load_versions():
        tag = f'{i[0]}.{i[1]}v{i[2]}'
        yield (
            "![Version](https://images.microbadger.com/badges/version/"
            f"natescarlet/nuke:{tag}.svg)\n"
        )
        yield (
            "![Image Info](https://images.microbadger.com/badges/image/"
            f"natescarlet/nuke:{tag}.svg)\n"
        )
        yield "\n"


def main():
    readme = (Path(__file__).parent.parent / "README.md")
    with readme.open() as f:
        lines = f.readlines()
    try:
        start = lines.index("<!-- image badges start -->\n")
        end = lines.index("<!-- image badges end -->\n")
    except ValueError:
        raise ValueError("image badges inject marker is missing")

    with readme.open("w") as f:
        f.writelines(chain(
            lines[:start + 1],
            ["\n"],
            _get_badges_lines(),
            lines[end:],
        ))


if __name__ == '__main__':
    main()
