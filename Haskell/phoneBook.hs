import Data.Maybe

type Name = String
type PhoneNumber = String
type PhoneBook = [(Name,PhoneNumber)]

-- Search for a phone number in a phone book.
getPhoneNumber :: Name -> PhoneBook -> Maybe PhoneNumber
getPhoneNumber name [] = Nothing
getPhoneNumber name (x:xs)
    | name == (fst x) = Just (snd x)
    | otherwise = getPhoneNumber name xs

-- Search for a phone number in a phone book, implemented with fold.
getPhoneNumberFold :: Name -> PhoneBook -> Maybe PhoneNumber
getPhoneNumberFold name x = foldl (\ acc (k, v) -> if k == name then Just v else acc) Nothing x