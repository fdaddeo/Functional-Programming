-- Extract a secret number, just once, between 1 and 90. The user has to guess it, repeatedly.
-- For any try, provide a suggestion to the user telling him if the guess is below or above the secret.
-- In addition, count and tell the number of tries because are not allowed more than 10 tries.

import System.Random

-- Implements the game logic.
-- Params: a secret number and the number of tries allowed.
playRound :: Int -> Int -> IO ()
playRound secret 10 = do 
    putStrLn  ("Secret number was: " ++ show secret ++ " but you reached the maximum number of tries.")
playRound secret tries = do
    putStrLn ("Attempt " ++ show tries ++ ". Please enter a number between 1 and 90.")
    guess <- getLine
    let guessInt = read guess :: Int
    if guessInt == secret
        then do
            putStrLn ("Amazing! You are correct!.")
        else do
            putStrLn ("Sorry, that wass not the secret number...")
            if guessInt < secret
                then do 
                    putStrLn ("... the secret number is higher :)")
                    playRound secret (tries + 1)
                else do
                    putStrLn ("... the secret number is lower :)")
                    playRound secret (tries + 1)

main :: IO ()
main = do
    secret <- getStdRandom (randomR (1, 90))
    playRound secret 1