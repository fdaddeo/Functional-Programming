-- Computes the mean value of a list.
-- Params: a list.
-- Returs: the list's mean value.
computeMean :: (Num a, Fractional a) => [a] -> a
computeMean list = (/) (sum list) (fromIntegral (length list))

-- Computes the mean value of the first five element of a list.
-- Params: a list.
-- Returs: the mean value of the first five element of a list.
average5 :: (Num a, Fractional a) => [a] -> a
average5 list = computeMean (take 5 list)