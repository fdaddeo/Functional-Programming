-- Implement the Collaz paradox
collatz :: (Integral a) => a -> [a]
collatz 1 = [1]
collatz n
    | even n =  n:collatz (n `div` 2)
    | odd n  =  n:collatz (n*3 + 1)

collazChain :: Int
collazChain = length (filter (\ x -> length x > 15) (map (collatz) [1, 2..100]))