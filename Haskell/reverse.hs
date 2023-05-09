-- Help function to reverse a list.
-- Params: a list and the accumulator corresponding to the partial list reversed.
-- Returns: the accumulator corresponding to the list reversed.
rev_tr :: [a] -> [a] -> [a]
rev_tr [] acc = acc
rev_tr (x:xs) acc = rev_tr xs (x:acc)

-- Reverses a list with tail recursion.
-- Params: a list.
-- Returns: the reversed list.
reverse' :: [a] -> [a]
reverse' [] = []
reverse' x = rev_tr x []