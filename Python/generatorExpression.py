from itertools import count, takewhile

def main():
    print(sum(takewhile(lambda x : x < 10000, (pow(x, 2) for x in count() if x % 2 != 0))))
                  
if __name__ == "__main__":
    main()