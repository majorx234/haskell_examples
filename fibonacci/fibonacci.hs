fibo :: Integer -> Integer
fibo 1 = 0
fibo 2 = 1
fibo n = fibo (n-1) + fibo (n-2)

fibo_forward :: Integer -> Integer
fibo_forward 1 = 0
fibo_forward 2 = 1
fibo_forward n = fibo_tail (1,2,n)

fibo_tail :: (Integer,Integer,Integer) -> Integer
fibo_tail (last,lastlast,3) = last
fibo_tail (last,lastlast,n) = fibo_tail (lastlast,last+lastlast,n-1)

fibs = 0:1:(zipWith (+) fibs (tail fibs))
