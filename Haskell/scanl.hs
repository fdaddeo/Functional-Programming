-- Implement the scanl function.
scanl' f z [] = [z]
scanl' f z (x:xs) = z : scanl' f (f z x) xs