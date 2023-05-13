-- Modify the “finalProject” project
-- Use a Haskell array instead of a list

import System.Random
import Data.Array

-- Transforms a String data into an Int data.
parseInt :: String -> Int
parseInt = read :: String -> Int

-- Checks if the given coordinate belongs to the matrix.
-- Params: a tuple representing the number of columns and rows and the index to be checked.
-- Returns: True if the index belongs to the matrix, False otherwise.
isInMatrix :: (Int, Int) -> (Int, Int) -> Bool
isInMatrix (cols, rows) (x, y) = x >= 1 && x <= cols && y >= 1 && y <= rows

-- Changes the 4 adjacent cells wrt the chosen one, |Δx| + |Δy| = 1, by flip their values.
-- Params: a tuple representing the number of columns and rows, the array of bools representing a matrix and the tuple indicating the cell to play on.
-- Returns: the updated array.
cleanUp :: (Int, Int) -> Array (Int, Int) Bool -> (Int, Int) -> Array (Int, Int) Bool
cleanUp (cols, rows) xs (x', y') =  xs // [((y + y', x + x'), not (xs!(y + y', x + x'))) | x <- [-1..1], y <- [-1..1], abs (x) + abs (y) == 1 && 
                                                                                                                       x + x' >= 1 &&
                                                                                                                       x + x' <= cols &&
                                                                                                                       y + y' >= 1 &&
                                                                                                                       y + y' <= rows]

-- Calls recursively the cleanUp function for `iter` times.
-- Params: a tuple representing the number of columns and rows, the array of bools, a standar generator and the number of iterations needed.
-- Returns: the "shuffled" array.
shuffleMatrix :: (Int, Int) -> Array (Int, Int) Bool -> StdGen -> Int -> Array (Int, Int) Bool
shuffleMatrix _ xs _ 0 = xs
shuffleMatrix (cols, rows) xs gen iter = 
    let (x, newGen) = randomR (1, rows) gen
        (y, newGen') = randomR (1, cols) newGen
    in shuffleMatrix (cols, rows) (cleanUp (cols, rows) xs (x, y)) newGen' (iter-1)

-- Checks if the game is over.
-- Params: the array of bools.
-- Returns: True if the game is over, False otherwise.
checkGameOver :: Array (Int, Int) Bool -> Bool
checkGameOver xs = not $ elem True xs

-- Implements the game logic.
-- Params: a tuple representing the number of columns and rows, the array of bools and the number of moves done so far.
play :: (Int, Int) -> Array (Int, Int) Bool -> Int -> IO ()
play dims xs moves = do
    if not (checkGameOver xs)
        then do
            print xs
            putStrLn ("Choose y [use -1 to quit]")
            yStr <- getLine
            putStrLn ("Choose x [use -1 to quit]")
            xStr <- getLine
            let y = parseInt yStr
                x = parseInt xStr
                cell = (x, y)
                curMoves = moves + 1
            if y /= -1 && x /= -1
                then do
                    if isInMatrix dims cell
                        then do
                            play dims (cleanUp dims xs cell) curMoves
                        else do
                            putStrLn ("Index out of range, please select another cell.")
                            play dims xs moves
                else do
                    putStrLn ("Game Stopped :(. You have done " ++ show moves ++ " moves.")
        else do
            putStrLn ("Game Over. You Won with " ++ show moves ++ " moves :).")

main :: IO()
main = do
    putStrLn ("Matrix Width:")
    widthStr <- getLine
    putStrLn ("Matrix Height:")
    heightStr <- getLine
    putStrLn ("Moves number:")
    movesStr <- getLine

    let width = parseInt widthStr
        height = parseInt heightStr
        moves = parseInt movesStr
        matrix = array ((1, 1), (height, width)) [((x, y), False) | x <-[1..width], y <- [1..height]]
        gameMatrix = shuffleMatrix (width, height) matrix (mkStdGen 123456) moves

    putStrLn ("Game ready!")
    play (width, height) gameMatrix 0
