-- Implements merge function of two sorted lists.
-- Params: two sorted lists.
-- Returns: Returns the sorted list, with all the elements.
merge :: (Ord a) => [a] -> [a] -> [a]
merge [] [] = []
merge [] x = x
merge x [] = x
merge (x:xs) (y:ys)
    | x <= y = x : xs `merge` (y:ys)
    | otherwise = y : (x:xs) `merge` ys

-- Implements the MergeSort algorithm: takes a list, splits it at half, sorts each part recursively and then merges the two sorted parts.
-- Params: a list.
-- Returns: the sorted list.
mergeSort :: (Ord a) => [a] -> [a]
mergeSort (x:[]) = [x]
mergeSort x = merge (mergeSort (take (div (fromIntegral (length x)) 2) x)) (mergeSort (drop (div (fromIntegral (length x)) 2) x))