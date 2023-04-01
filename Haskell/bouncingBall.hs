-- Define Ball data type with its center (x, y) and movement offsets.
data Ball = Ball { x :: Int
                 , y :: Int
                 , dx :: Int
                 , dy :: Int
                 } deriving(Show)

-- Define the arena dimensions.
arenaW = 480
arenaH = 360

-- Define the ball dimensions.
ballW = 20
ballH = 20

-- Move the ball by its movement offset.
move :: Ball -> Ball
move (Ball x y dx dy)
    | x + dx > arenaW - ballW = move (Ball x y (-dx) dy)
    | x + dx < 0 = move (Ball x y (-dx) dy)
    | y + dy > arenaH - ballH = move (Ball x y dx (-dy))
    | y + dy < 0 = move (Ball x y dx (-dy))
    | otherwise = Ball (x + dx) (y + dy) dx dy