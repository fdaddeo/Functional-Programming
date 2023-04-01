from functools import partial
from itertools import count, takewhile

def main():
    pow2 = partial(pow, exp=2)

    print(sum(filter(lambda x: x % 2 != 0, takewhile(lambda y: y < 10000, map(pow2, count())))))


if __name__ == "__main__":
    main()