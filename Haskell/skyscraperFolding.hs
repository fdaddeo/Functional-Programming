-- Count how many times the maximum of a list changes with fold function.
-- Params: a list.
-- Returns: the number of the maximum changed from left to right.
skyscraperFold :: (Num a, Ord a) => [a] -> a
skyscraperFold xs = snd (foldl (\ (maxVal, countMax) x -> if x > maxVal then (x, countMax + 1) else (maxVal, countMax)) (0, 0) xs)

-- skyscraperFold xs = foldl (\ acc x -> changeMax acc x) (0, 0) xs
--     where changeMax (max, count) x
--             | x > max = (x, count + 1)
--             | otherwise = (max, count)