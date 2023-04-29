-- Which right triangle that has integers for all side
-- and all sides equal to or smaller than 10 has a perimeter of 24?

whichTriangle = [(x, y, z) | x <- [1..10], y <- [x..10], let z = 24-x-y, z*z == x*x + y*y]