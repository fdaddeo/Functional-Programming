if __name__ == "__main__":

    triangle = [(x, y, z) for x in range(1, 11) for y in range(x, 11)  for z in range(1, 25-x-y) if (x + y + z == 24) and (z == (x ** 2 + y ** 2) ** 0.5)]
    print(triangle)