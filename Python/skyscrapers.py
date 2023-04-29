"""
Given a list of positive integers values, how many times does the maximum change?
Like counting the skyscrapers' tops which can be seen, looking from left to right.
"""

from random import shuffle

def count_tops(values: list[int]) -> int:
    """
    Counts how many time the maximum change in a list, looking from left to right.

    :param values: The list in which count the maximum changes.
    :return: The number of times the maximum changed.
    """
    
    max_item = values[0]
    max_changing = 1
    
    for idx, item in enumerate(values, 1):
        if (item > max_item):
            max_item = item
            max_changing += 1

    return max_changing

def main():
    values = list(range(1, 6))
    shuffle(values)

    max_changing = count_tops(values)
    print(max_changing)

if __name__ == "__main__":
    main()