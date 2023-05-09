-- Implements the Collaz function.
-- Param: a number from which start the sequence.
-- Returns: the obtained collatz chain.
collatz :: (Integral a) => a -> [a]
collatz 1 = [1]
collatz n
    | even n =  n:collatz (n `div` 2)
    | odd n  =  n:collatz (n*3 + 1)

-- Computes how many Collatz chain have a length greater than 15.
-- Returns: the resulting number of Collatz chain.
collazChain :: Int
collazChain = length (filter (\ x -> length x > 15) (map (collatz) [1, 2..100]))