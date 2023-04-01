-- Compute the mean value of a list.
computeMean :: (Num a, Fractional a) => [a] -> a
computeMean list = (/) (sum list) (fromIntegral (length list))

-- Compute the mean value of the first five element of a list.
average5 :: (Num a, Fractional a) => [a] -> a
average5 list = computeMean (take 5 list)