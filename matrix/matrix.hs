data Nat = Zero | Succ Nat

type Matrix a = [[a]]

transpose :: Matrix a -> Matrix a
transpose (x:[]) = map (\ v -> (v:[])) x 
transpose (x:xs) = zipWith (:) x (transpose xs)

multiply :: (Num a) => Matrix a -> Matrix a -> Matrix a
multiply xm ym = map (\ x_row -> (map (\ y_column -> sum (zipWith (*) x_row y_column)) (transpose ym))) xm
