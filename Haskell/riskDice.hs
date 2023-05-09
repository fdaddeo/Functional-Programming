-- Each of two players (attacker A and defender D) rolls three dices.
-- Dices are compared in couples: A's highest die against D's highest die... and so on. In case of equal values, D's die wins.
-- Repeat the game N times and create a list of N integer results. 
-- Optionally, also count the occurrences of each possible result (0-3)

import System.Random
import Data.List

-- Rolls three dices.
-- Params: a standard generator.
-- Returns: a the list containing the three extracted values.
rollThreeDice :: StdGen -> [Int]
rollThreeDice gen =
    let (first, newGen) = randomR (1, 6) gen
        (second, newGen') = randomR (1, 6) newGen
        (third, newGen'') = randomR (1, 6) newGen'
    in  [first, second, third]

-- Checks if the attacker wins against the defender.
-- Params: a list representing the attacker dices and a list representing the defender dices.
-- Returns: a list of boolean indicating True when the attacker wins.
checkResult :: [Int] -> [Int] -> [Bool]
checkResult attackDice defendDice = zipWith (>) (sort attackDice) (sort defendDice)

-- Counts how many times the attacker wins.
-- Params: a list of boolean representing the result of the attack.
-- Returns: the number of times the attacker wins.
countWin :: [Bool] -> Int
countWin xs = foldl (\ acc res -> if res == True then acc + 1 else acc) 0 xs

-- Implements `n` rounds.
-- Params: a standard generator, the number of rounds left and a list of partial results.
-- Returns: the list containing the the number of attacker wins in each round.
play :: Int -> Int -> [Int] -> [Int]
play mkGen 0 list = list
play mkGen n list = play (mkGen + 2) (n - 1) (countWin (checkResult (rollThreeDice (mkStdGen mkGen)) (rollThreeDice (mkStdGen (mkGen + 1)))):list)

-- Counts the occurences for each win of the attacker.
-- Params: a list representing the number of attacker wins.
-- Returns: the list containing the occurences for each attacker win.
countOccurences :: [Int] -> [Int]
countOccurences results = 
    let zeros = length (filter (== 0) results)
        ones = length (filter (== 1) results)
        twos = length (filter (== 2) results)
        threes = length (filter (== 3) results)
    in [zeros, ones, twos, threes]

-- Starts the game.
-- Params: the number of rounds.
-- Returns: the tuple representing the attacker wins and their occurences.
playRiskDice :: Int -> ([Int], [Int])
playRiskDice n = 
    let results = play 123456 n []
        occurences = countOccurences results
    in (results, occurences)