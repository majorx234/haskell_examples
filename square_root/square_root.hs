sqr_aux :: Double -> Double -> Double -> Double -> Double
sqr_aux a eps h h_old |(h - h_old) * (h - h_old) < eps*eps = h
                      |otherwise = sqr_aux a eps (0.5*h + 0.5*a/h) h

sqr :: Double -> Double -> Double
sqr a eps = sqr_aux a eps ((1 + a)/2) (2*a)


sqr2 :: Double -> Double -> Double
sqr2 a eps = sqr_aux a eps ((1 + a)/2) (2*a)
             where sqr_aux2 a eps h h_old |(h - h_old) * (h - h_old) < eps*eps = h
                                          |otherwise = sqr_aux2 a eps (0.5*h + 0.5*a/h) h

count :: Double -> Double -> Int
count a eps = count_aux a eps ((1 + a)/2) (2*a) 0
              where count_aux a eps h h_old num_it|(h - h_old) * (h - h_old) < eps*eps = num_it
                                                  |otherwise = count_aux a eps (0.5*h + 0.5*a/h) h (num_it + 1)
