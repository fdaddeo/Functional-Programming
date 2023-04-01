-- Help function to count how many time the maximum of a list changes.
skyscraper_tr :: (Num a, Ord a) => [a] -> [a] -> a
skyscraper_tr [] acc = (fromIntegral (length acc))
skyscraper_tr (x:xs) [] = skyscraper_tr xs [x]
skyscraper_tr (x:xs) acc
    | x > oldMax = skyscraper_tr xs (x:acc)
    | otherwise = skyscraper_tr xs acc
    where oldMax = head acc

-- Count how many time the maximum of a list changes with tail recursion.
skyscraper :: (Num a, Ord a) => [a] -> a
skyscraper [] = error "empty list"
skyscraper x = skyscraper_tr x []