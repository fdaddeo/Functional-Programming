from random import shuffle

def counting_top(values: list[int]):
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