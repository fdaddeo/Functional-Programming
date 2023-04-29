-- Implement a max function.
-- Given two parameters, returns the maximum of the two.
maxOfTwo :: (Ord a) => a -> a -> a
maxOfTwo a b
    | a < b = b
    | b <= a = a

-- Transform a string into an operation.
-- Params: a string and two numbers. The string param represents the operation to perform on the two numbers.
-- Returns: a string. Return the result, as a textual message.
calculate :: String -> Float -> Float -> String
calculate "+" x y = show (x + y)
calculate "-" x y = show (x - y)
calculate "*" x y = show (x * y)
calculate "/" x 0 = "Error division by 0"
calculate "/" x y = show ((/) x y)
calculate (s:_) x y = "Too many arguments"