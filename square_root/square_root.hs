sqr_aux :: Double -> Double -> Double -> Double -> Double
sqr_aux x eps h h_old |(h - h_old) * (h - h_old) < eps*eps = h
                      |otherwise = sqr_aux x eps (0.5*h + 0.5*x/h) h

sqr :: Double -> Double -> Double
sqr x eps = sqr_aux x eps ((1 + x)/2) (2*x)
