-- Implement merge function of two lists.
merge :: (Ord a) => [a] -> [a] -> [a]
merge [] [] = []
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys)
    | x <= y = x : xs `merge` (y:ys)
    | otherwise = y : (x:xs) `merge` ys

-- Implement the mergeSort algorithm.
mergeSort :: (Ord a) => [a] -> [a]
mergeSort (x:[]) = [x]
mergeSort x = merge (mergeSort (take (div (fromIntegral (length x)) 2) x)) (mergeSort (drop (div (fromIntegral (length x)) 2) x))