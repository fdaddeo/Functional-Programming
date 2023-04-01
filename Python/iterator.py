from random import shuffle
from math import inf

class CountingTop:
    def __init__(self, values):
        self._values = values

    def __iter__(self):
        self._max = - inf
        self._index = 0
        return self

    def __next__(self):
        if self._index > (len(self._values) - 1):
            raise StopIteration
        
        val = self._values[self._index]
        if val > self._max:
            self._max = val
        else:
            while True:
                self._index += 1
                if self._index > (len(self._values) - 1):
                    raise StopIteration
                
                val = self._values[self._index]
                if val > self._max:
                    self._max = val
                    break
                
        self._index += 1
        
        return self._max
    
def main():
    values = list(range(1, 6))
    shuffle(values)
    print(f"List values: {values}")

    countingTop = CountingTop(values)

    for idx, val in enumerate(countingTop, 0):
        print(val)

if __name__ == "__main__":
    main()