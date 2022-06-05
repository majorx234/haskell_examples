data Nat = Zero | Succ Nat

type Matrix a = [[a]]

transpose :: Matrix a -> Matrix a
transpose (x:[]) = map (\ v -> (v:[])) x 
transpose (x:xs) = zipWith (:) x (transpose xs)
