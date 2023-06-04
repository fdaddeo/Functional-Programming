import System.Random
import Control.Monad

class (Show a) => Actor a where
    move :: String -> [a] -> a -> [a]
    rect :: a -> (Int, Int, Int, Int)  -- (x, y, w, h)

data Arena a = Arena { actors :: [a]
                     } deriving (Show)

tick :: (Actor a) => Arena a -> String -> Arena a
tick (Arena actors) keys = Arena $ concat (map (move keys actors) actors)

operateArena :: (Actor a) => Arena a -> IO ()
operateArena arena = do
    print arena
    line <- getLine
    when (line /= "q") $ operateArena (tick arena line)

checkCollision :: (Actor a) => a -> a -> Bool
checkCollision a1 a2 = (rect a1) /= (rect a2) && y2 < y1+h1 && y1 < y2+h2 && x2 < x1+w1 && x1 < x2+w2
    where
        (x1, y1, w1, h1) = rect a1
        (x2, y2, w2, h2) = rect a2

maxX = 320
maxY = 240
actorW = 20
actorH = 20

ballSpeed = 5
ghostSpeed = 4
turtleSpeed = 2

data BasicActor = Ball { x :: Int, y :: Int, dx :: Int, dy :: Int }
                | Ghost { x :: Int, y :: Int, rnd :: StdGen }
                | Turtle { x :: Int, y :: Int, dead :: Bool } deriving (Show)

collide :: BasicActor -> BasicActor -> BasicActor
collide (Ball x y _ _) (Ball x2 y2 _ _)
    | x2 < x  && y2 < y  = Ball x y ballSpeed ballSpeed
    | x2 >= x && y2 < y  = Ball x y (-ballSpeed) ballSpeed
    | x2 < x  && y2 >= y = Ball x y ballSpeed (-ballSpeed)
    | x2 >= x && y2 >= y = Ball x y (-ballSpeed) (-ballSpeed)
collide (Ball x y dx dy) (Turtle x2 y2 dead)
    | dead == True       = Ball x y dx dy
    | x2 < x  && y2 < y  = Ball x y ballSpeed ballSpeed
    | x2 >= x && y2 < y  = Ball x y (-ballSpeed) ballSpeed
    | x2 < x  && y2 >= y = Ball x y ballSpeed (-ballSpeed)
    | x2 >= x && y2 >= y = Ball x y (-ballSpeed) (-ballSpeed)
collide (Turtle x y dead) (Ball x2 y2 dx2 dy2) = Turtle x y True
collide a _ = a

-- Uniformly chooses the ghost speed starting from a random number in range 1 to 9.
-- Params: A random integer in range 1 to 9.
-- Returns: The ghost speed.
randomChoice :: Int -> Int
randomChoice rnd
    | rnd <= 3            = -ghostSpeed
    | rnd > 3 && rnd <= 6 = 0
    | rnd >= 6            = ghostSpeed

-- Returns if it's needed to generate a new Ball.
-- Params: A random integer in range 0 to n.
-- Returns: True it has been generated a new Ball, False otherwise.
randomSpawnBall :: Int -> Bool
randomSpawnBall rnd
    | rnd == 0  = True
    | otherwise = False

instance Actor BasicActor where
    rect (Ball x y _ _) = (x, y, actorW, actorH)
    rect (Ghost x y _) = (x, y, actorW, actorH)
    rect (Turtle x y _) = (x, y, actorW, actorH)
    move keys actors (Ball x y dx dy)
        | x + dx < 0 && y + dy < 0                         = [foldl (\ ballUpdated (actor, True) -> collide ballUpdated actor) (Ball (x+dx) (y+dy) ballSpeed ballSpeed) (filter (id snd)  (zip actors (map (checkCollision (Ball x y dx dy)) actors)))]
        | x + dx < 0 && y + dy > maxY - actorH             = [foldl (\ ballUpdated (actor, True) -> collide ballUpdated actor) (Ball (x+dx) (y+dy) ballSpeed (-ballSpeed)) (filter (id snd)  (zip actors (map (checkCollision (Ball x y dx dy)) actors)))]
        | x + dx > maxX - actorW && y + dy < 0             = [foldl (\ ballUpdated (actor, True) -> collide ballUpdated actor) (Ball (x+dx) (y+dy) (-ballSpeed) ballSpeed) (filter (id snd)  (zip actors (map (checkCollision (Ball x y dx dy)) actors)))]
        | x + dx > maxX - actorW && y + dy > maxY - actorH = [foldl (\ ballUpdated (actor, True) -> collide ballUpdated actor) (Ball (x+dx) (y+dy) (-ballSpeed) (-ballSpeed)) (filter (id snd)  (zip actors (map (checkCollision (Ball x y dx dy)) actors)))]
        | otherwise                                        = [foldl (\ ballUpdated (actor, True) -> collide ballUpdated actor) (Ball (x+dx) (y+dy) dx dy) (filter (id snd)  (zip actors (map (checkCollision (Ball x y dx dy)) actors)))]
    move keys actors (Ghost x y rnd)
        | spawnBall == True = [(Ball x y (-dx) (-dy)), (Ghost ((x+dx) `mod` maxX) ((y+dy) `mod` maxY) newGen'')]
        | otherwise         = [(Ghost ((x+dx) `mod` maxX) ((y+dy) `mod` maxY) newGen'')]
        where (rndX, newGen)  = randomR (1, 9) rnd
              (rndY, newGen') = randomR (1, 9) newGen
              (rndSpawnBall, newGen'') = randomR (0, 1000) newGen'
              dx = randomChoice rndX
              dy = randomChoice rndY
              spawnBall = randomSpawnBall rndSpawnBall
    move keys actors (Turtle x y dead)
        | dead == True                                   = []
        | keys == "w" && y + turtleSpeed < maxY - actorH = [foldl (\ turtleUpdated (actor, True) -> collide turtleUpdated actor) (Turtle x (y-turtleSpeed) dead) (filter (id snd) (zip actors (map (checkCollision (Turtle x y dead)) actors)))]
        | keys == "a" && x - turtleSpeed >= 0            = [foldl (\ turtleUpdated (actor, True) -> collide turtleUpdated actor) (Turtle (x-turtleSpeed) y dead) (filter (id snd) (zip actors (map (checkCollision (Turtle x y dead)) actors)))]
        | keys == "s" && y - turtleSpeed >= 0            = [foldl (\ turtleUpdated (actor, True) -> collide turtleUpdated actor) (Turtle x (y+turtleSpeed) dead) (filter (id snd) (zip actors (map (checkCollision (Turtle x y dead)) actors)))]
        | keys == "d" && x + turtleSpeed < maxX - actorW = [foldl (\ turtleUpdated (actor, True) -> collide turtleUpdated actor) (Turtle (x+turtleSpeed) y dead) (filter (id snd) (zip actors (map (checkCollision (Turtle x y dead)) actors)))]
        | otherwise                                      = [foldl (\ turtleUpdated (actor, True) -> collide turtleUpdated actor) (Turtle x y dead) (filter (id snd) (zip actors (map (checkCollision (Turtle x y dead)) actors)))]

main = do
    rnd <- newStdGen
    operateArena (Arena [Ball 200 100 5 5, Ball 230 120 (-5) (-5), Ghost 100 100 rnd, Turtle 160 120 False])