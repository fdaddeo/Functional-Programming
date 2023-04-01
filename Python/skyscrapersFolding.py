from random import shuffle
from functools import reduce

def main():
    values = list(range(1, 6))
    shuffle(values)

    print(f"List: {values}")
    print(f"Counting max: {reduce(lambda acc, x: (x, acc[1] + 1) if x > acc[0] else acc, values, (0, 0))[1]}")

if __name__ == "__main__":
    main()