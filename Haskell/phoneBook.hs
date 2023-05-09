import Data.Maybe

-- Define data type.
type Name = String
type PhoneNumber = String
type PhoneBook = [(Name,PhoneNumber)]

-- Searches for a phone number in a phone book.
-- Params: a name and a phone book.
-- Returns: the phone number if found, Nothing otherwise.
getPhoneNumber :: Name -> PhoneBook -> Maybe PhoneNumber
getPhoneNumber name [] = Nothing
getPhoneNumber name (x:xs)
    | name == (fst x) = Just (snd x)
    | otherwise = getPhoneNumber name xs

-- Searches for a phone number in a phone book, implemented with fold.
-- Params: a name and a phone book.
-- Returns: the phone number if found, Nothing otherwise.
getPhoneNumberFold :: Name -> PhoneBook -> Maybe PhoneNumber
getPhoneNumberFold name x = foldl (\ acc (k, v) -> if k == name then Just v else acc) Nothing x