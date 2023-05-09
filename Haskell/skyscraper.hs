-- Help function to count how many times the maximum of a list changes.
-- Params: a list and the accumulator corresponding to each maximum seen from left to right.
-- Returns: the length of the accumulator.
skyscraper_tr :: (Num a, Ord a) => [a] -> [a] -> a
skyscraper_tr [] acc = (fromIntegral (length acc))
skyscraper_tr (x:xs) [] = skyscraper_tr xs [x]
skyscraper_tr (x:xs) acc
    | x > oldMax = skyscraper_tr xs (x:acc)
    | otherwise = skyscraper_tr xs acc
    where oldMax = head acc

-- Counts how many times the maximum of a list changes with tail recursion.
-- Params: a list.
-- Returns: the number of the maximum changed from left to right.
skyscraper :: (Num a, Ord a) => [a] -> a
skyscraper [] = error "empty list"
skyscraper x = skyscraper_tr x []