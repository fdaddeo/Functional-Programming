-- Implements a max function.
-- Params: two numbers.
-- Returns: the maximum of the two parameters.
maxOfTwo :: (Ord a) => a -> a -> a
maxOfTwo a b
    | a < b = b
    | b <= a = a

-- Transforms a string into an operation.
-- Params: a string and two numbers. The string represents the operation to be performed with the two numbers.
-- Returns: the result as textual message.
calculate :: String -> Float -> Float -> String
calculate "+" x y = show (x + y)
calculate "-" x y = show (x - y)
calculate "*" x y = show (x * y)
calculate "/" x 0 = "Error division by 0"
calculate "/" x y = show ((/) x y)
calculate (s:_) x y = "Too many arguments"