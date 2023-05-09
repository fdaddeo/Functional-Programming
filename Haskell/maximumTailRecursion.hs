-- Help function
-- Params: a list and the accumulator
-- Returns: the accumulator, which correspons to the maximum in the list.
maxInList_tr :: (Num a, Ord a) => [a] -> a -> a
maxInList_tr [] acc = acc
maxInList_tr (x:xs) acc
    | x < acc = maxInList_tr xs acc
    | otherwise = maxInList_tr xs x

-- Computes the maximum of a list with tail recursion.
-- Params: a list.
-- Returns: the maximum value in the list.
maxInList :: (Num a, Ord a) => [a] -> a
maxInList [] = error "empty list"
maxInList x = maxInList_tr x 0