"""Get image badges markdown for README.md.  """
from update_config import get_versions


def main():
    for i in get_versions():
        tag = f'{i[0]}.{i[1]}v{i[2]}'
        print(f'''\
![Version](https://images.microbadger.com/badges/version/natescarlet/nuke:{tag}.svg)
![Image Info](https://images.microbadger.com/badges/image/natescarlet/nuke:{tag}.svg)
''')


if __name__ == '__main__':
    main()
