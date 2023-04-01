-- Implement a function that returns the squared sum of the odd number less than 10000.
oddSquares :: Int
oddSquares = sum (filter odd (takeWhile (<10000) (map (^2) [1, 2..])))