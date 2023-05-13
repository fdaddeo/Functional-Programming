-- Prepare a clean w×h matrix and play m random moves, where w, h, m are configurable.
-- Use the “clean-up” function, to play a move, possibly avoiding repeating the moves (play m different moves).
-- Then, allow the user to play: check if the matrix is completely cleaned up (solved) and count user's moves.

import System.Random

-- Transforms a String data into an Int data.
parseInt :: String -> Int
parseInt = read :: String -> Int

-- Checks if the given coordinate belongs to the matrix.
-- Params: a tuple representing the number of columns and rows and the index to be checked.
-- Returns: True if the index belongs to the matrix, False otherwise.
isInMatrix :: (Int, Int) -> Int -> Bool
isInMatrix (cols, rows) x =  x >= 0 && x < (cols * rows)

-- Changes the 4 adjacent cells wrt the chosen one, |Δx| + |Δy| = 1, by flip their values.
-- Params: a tuple representing the number of columns and rows, the list of bools representing a matrix and the integer indicating the cell to play on.
-- Returns: the updated list.
cleanUp :: (Int, Int) -> [Bool] -> Int -> [Bool]
cleanUp (cols, rows) xs cell =
    reverse $ fst $ foldl (\ (newXS, idx) elem -> let (y', x') = idx `divMod` cols 
                                                  in if abs (y - y') + abs (x - x') == 1 
                                                        then ((not elem):newXS, idx+1)
                                                        else (elem:newXS, idx+1)
                          ) ([], 0) xs
    where (y, x) = cell `divMod` cols

-- Calls recursively the cleanUp function for `iter` times.
-- Params: a tuple representing the number of columns and rows, the list of bools, a standar generator and the number of iterations needed.
-- Returns: the "shuffled" list.
shuffleMatrix :: (Int, Int) -> [Bool] -> StdGen -> Int -> [Bool]
shuffleMatrix _ xs _ 0 = xs
shuffleMatrix (cols, rows) xs gen iter = 
    let (cell, newGen) = randomR (0, (cols * rows)) gen
    in shuffleMatrix (cols, rows) (cleanUp (cols, rows) xs cell) newGen (iter-1)

-- Checks if the game is over.
-- Params: the list of bools.
-- Returns: True if the game is over, False otherwise.
checkGameOver :: [Bool] -> Bool
checkGameOver xs = not $ elem True xs

-- Implements the game logic.
-- Params: a tuple representing the number of columns and rows, the list of bools and the number of moves done so far.
play :: (Int, Int) -> [Bool] -> Int -> IO ()
play dims xs moves = do
    if not (checkGameOver xs)
        then do
            print xs
            putStrLn ("Choose your move [use -1 to quit]")
            cellStr <- getLine
            let cell = parseInt cellStr
                curMoves = moves + 1
            if cell /= -1
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
        matrix = take (width * height) (repeat False)
        gameMatrix = shuffleMatrix (width, height) matrix (mkStdGen 123456) moves

    putStrLn ("Game ready!")
    play (width, height) gameMatrix 0