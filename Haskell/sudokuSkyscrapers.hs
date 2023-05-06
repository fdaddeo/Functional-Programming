-- Read one of the files contained in skyscrapers_game folder in Haskell. 
-- Then represent data as a list of lists of ints, i.e., [[Int]].
-- The numbers on the borders are the *constraints* to satisfy check 
-- if data complies with the following rules of the skyscrapers game and 
-- check also uniqueness and range of values.

import System.IO
import Data.List

-- Transforms a String data into an Int data
parseInt :: String -> Int
parseInt = read :: String -> Int

-- Parses a row by inserting each element in a list.
-- Params: the matrix row to be parsed and the accumulator.
-- Returns: a list of Int corresponding to the matrix row.
parseRow :: [String] -> [[Int]] -> [[Int]]
parseRow (x:[]) acc = ((map parseInt (words x)):acc)
parseRow (x:xs) acc = parseRow xs ((map parseInt (words x)):acc)

-- Parses a file containing a matrix.
-- Params: the name of the file to be parsed.
-- Returns: a list of list of Int, where each inner list correspond to a matrix row.
parseFile :: String -> IO ([[Int]])
parseFile fileName = do
    contents <- readFile fileName
    let rows = lines contents
        values = reverse (parseRow rows [])
    return values

-- Removes the first and the last element from a list.
-- Params: a list.
-- Returns: the list without the first and the last element.
rowPreprocess :: [Int] -> [Int]
rowPreprocess xs = init (tail xs)

-- Checks the correctness of a row by accumulating the number of times in which the maximum has changed.
-- Params: a row. Basically, a list of integers.
-- Returns: a tuple containing the maximum value and the number of times the maximum has changed. If the rule is 0, then it returns 0. 
checkRow :: [Int] -> Int -> (Int, Int)
checkRow xs 0 = (0, 0)
checkRow xs rule = foldl (\ (prevMax, acc) x -> if x <= 0 then (prevMax, acc+1) else if x >= prevMax then (x, acc+1) else (prevMax, acc)) (0, 0) xs

-- Checks the correctness of a row by accumulating 0 if each row is correct, -1 otherwise.
-- Params: a matrix. Basically, a list of list of integers.
-- Returns: 0 if the matrix is correct, -1 otherwise.
checkMatrix :: [[Int]] -> Int
checkMatrix xs = foldl (\ acc x -> let row = rowPreprocess x
                                       rowR = rowPreprocess (reverse x)
                                       (maxVal, maxChanges) = checkRow row (head x)
                                       (maxValR, maxChangesR) = checkRow rowR (last x)
                                       maximumPossibleValue = length row
                                   in if maxChanges == head x && 
                                         maxVal <= maximumPossibleValue &&
                                         maxChangesR == last x &&
                                         maxValR <= maximumPossibleValue &&
                                         acc == 0 
                                      then 0 
                                      else -1 
                        ) 0 xs

main :: IO ()
main = do
    putStrLn ("Digit the file name:")
    fileName <- getLine
    matrix <- parseFile fileName
    let result = checkMatrix matrix
    let resultT = checkMatrix (transpose matrix)
    if result /= -1 && resultT /= -1
        then do
            putStrLn ("That's correct! Game Won.")
        else do
            putStrLn ("I'm sorry... There were some mistake in the solution :(")