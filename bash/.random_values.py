import argparse
import random
import string

CARACTERS = string.ascii_lowercase + string.ascii_uppercase + string.digits


def display_random(value_type: str) -> str:

    if value_type == 'str':
        return ''.join([random.choice(CARACTERS) for _ in range(10)])

    number = random.randint(0, int(1e10))
    if value_type == 'hex':
        return f'0x{number:x}'

    if value_type == 'int':
        return f'{number:d}'

    raise ValueError('Invalid option. Choose between "hex", "str", or "int".')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(
        description='Generate random values of different types.'
    )
    parser.add_argument(
        'type',
        choices=['hex', 'str', 'int'],
        help=(
            'Choose the type of value to generate: "hex" for hexadecimal, '
            '"str" for string, or "int" for integer.'
        ),
    )

    args = parser.parse_args()

    try:
        r = display_random(args.type)
        print(r)
    except ValueError as err:
        print(err)
