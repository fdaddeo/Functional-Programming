"""
Write a Python generator instantiated over a list of ints that produces value in such way that
each new maximum tops seen looking from left to right.
"""

from random import shuffle

def counting_top(values: list[int]):
    """
    Counts how many time the maximum change in a list, looking from left to right, and returns a Generator.

    :param values: The list in which count the maximum changes.
    """

    max_value = -1

    for idx, item in enumerate(values, 0):
        if item > max_value:
            yield(item)
            max_value = item

def main():
    values = list(range(1, 6))
    shuffle(values)
    print(f"List values: {values}")

    changing_max = list(counting_top(values))
    print(f"Results: {changing_max}")

if __name__ == "__main__":
    main()