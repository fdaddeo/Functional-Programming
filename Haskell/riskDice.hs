import System.Random
import Data.List

rollThreeDice :: StdGen -> [Int]
rollThreeDice gen =
    let (first, newGen) = randomR (1, 6) gen
        (second, newGen') = randomR (1, 6) newGen
        (third, newGen'') = randomR (1, 6) newGen'
    in  [first, second, third]

checkResult :: [Int] -> [Int] -> [Bool]
checkResult attackDice defendDice = zipWith (>) (sort attackDice) (sort defendDice)

countWin :: [Bool] -> Int
countWin xs = foldl (\ acc res -> if res == True then acc + 1 else acc) 0 xs

play :: Int -> Int -> [Int] -> [Int]
play mkGen 0 list = list
play mkGen n list = play (mkGen + 2) (n - 1) (countWin (checkResult (rollThreeDice (mkStdGen mkGen)) (rollThreeDice (mkStdGen (mkGen + 1)))):list)

countOccurences :: [Int] -> [Int]
countOccurences results = 
    let zeros = length (filter (== 0) results)
        ones = length (filter (== 1) results)
        twos = length (filter (== 2) results)
        threes = length (filter (== 3) results)
    in [zeros, ones, twos, threes]


playRiskDice :: Int -> ([Int], [Int])
playRiskDice n = 
    let results = play 123456 n []
        occurences = countOccurences results
    in (results, occurences)