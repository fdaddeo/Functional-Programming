-- Implement a max function
maxOfTwo :: (Ord a) => a -> a -> a
maxOfTwo a b
    | a < b = b
    | b <= a = a

-- Transform a string into an operation
calculate :: String -> Float -> Float -> String
calculate "+" x y = show (x + y)
calculate "-" x y = show (x - y)
calculate "*" x y = show (x * y)
calculate "/" x 0 = "Error division by 0"
calculate "/" x y = show ((/) x y)
calculate (s:_) x y = "Too many arguments"