-- Help function
maxInList_tr :: (Num a, Ord a) => [a] -> a -> a
maxInList_tr [] acc = acc
maxInList_tr (x:xs) acc
    | x < acc = maxInList_tr xs acc
    | otherwise = maxInList_tr xs x

-- Compute the maximum of a list with tail recursion
maxInList :: (Num a, Ord a) => [a] -> a
maxInList [] = error "empty list"
maxInList x = maxInList_tr x 0