-- Help function to reverse a list.
rev_tr :: [a] -> [a] -> [a]
rev_tr [] acc = acc
rev_tr (x:xs) acc = rev_tr xs (x:acc)

-- Reverse a list with tail recursion.
reverse' :: [a] -> [a]
reverse' [] = []
reverse' x = rev_tr x []