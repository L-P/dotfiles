import sys
import builtins

def format_number(item):
    if isinstance(item, int):
        print("{} 0x{:08X} {:#032b}".format(repr(item), item, item))
    else:
        print(repr(item))

    builtins._ = item

sys.displayhook = format_number
