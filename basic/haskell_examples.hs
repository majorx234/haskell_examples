import System.Random
import Data.List


myinc :: Int -> Int
myinc x = x+1

exclaim :: String -> String
exclaim sentence = sentence ++  "!"

myplus :: Num a => a-> a-> a
myplus a1 a2 = (a1 + a2)

myfoldr :: (a -> b -> b) -> b -> [a] -> b
myfoldr _ z  [] = z
myfoldr f z (x:xs) = f x (myfoldr f z xs)

mypred :: Int -> Bool
mypred x | x == 1 = True
         | otherwise = False

myfilter :: (a->Bool) -> [a] -> [a]
myfilter pred [] = []
myfilter pred (x:xs)
  | pred x = x : myfilter pred xs
  | otherwise = myfilter pred xs

myfilter_int :: Num a => (a->Bool) -> [a] -> [a]
myfilter_int pred [] = []
myfilter_int pred (x:xs)
  | pred x = x : myfilter pred xs
  | otherwise = 0 : myfilter pred xs


matrix_mul [] [] = []
matrix_mul [] (x:xs) = []
matrix_mul (x:xs) [] = []
matrix_mul (x:xs) (y:ys) = x * y : ( matrix_mul xs ys )

--function concatination
quad :: Int -> Int
quad x = x*x

double :: Int -> Int
double x = 2*x

quad_d :: Int -> (Int,String)
quad_d x = (x*x , "quad_d")

double_d :: Int -> (Int,String)
double_d x = (2*x,"double_d")

double_quad :: Int -> Int
double_quad x = (double . quad) x

lift_debug :: (a -> b) -> (a -> (b,String))
lift_debug f x = let y = f x in (y, "_" )

f_concat_debug :: (b -> (c,String) ) -> (a -> (b , String)) -> (a -> (c , String))
f_concat_debug f g x = let (yg , str_g) = g x
                       in
                         let (yf , str_f) = f yg
                         in
                           ( yf , str_g ++ " . " ++ str_f)

myrand :: (Random a, Num a) => Int -> (a, StdGen)
myrand x = randomR (0,0) (mkStdGen x)

--f_rand :: a-> StdGen -> (b , StdGen)
f_rand x gen = let (x1 , gen1) = (randomR (0,0) gen)
               in
                 (x * x1,gen1)
--g_rand :: b-> StdGen -> (c , StdGen)
g_rand x gen = let (x2,gen2) = (randomR (0,0) gen)
               in
                 (x + x2 ,gen2)

concat_rand g f gen = let (x , gen1) = g gen
                      in
                        f x gen1

einheit :: t -> t1 -> (t, t1)
einheit x gen = (x , gen)

lift_rand f = einheit . f

--maybe
isJust :: Maybe a -> Bool
isJust (Just _) = True
isJust Nothing  = False

un_maybe :: b -> (a -> b) -> Maybe a -> b
un_maybe _ f (Just x) = f x
un_maybe z _ Nothing  = z

isNothing :: Maybe a -> Bool
isNothing (Just _) = False
isNothing Nothing  = True

--odd_maybe :: a -> Maybe a
odd_maybe x
  | x == 1 = Just x
  | otherwise = Nothing

return :: a -> Maybe a
return x  = Just x

--einheit
einheit_maybe :: (a-> Maybe a)
einheit_maybe x = Just x

--verbind
concat_maybe :: (Maybe a -> Maybe b) -> (Maybe b -> Maybe c) -> Maybe a -> Maybe c
concat_maybe m_f m_g x = let y_g = (m_f x)
                         in (if (isJust y_g) then (m_g y_g) else Nothing)
--lift
lift_maybe f = einheit_maybe . f

-- currying

add1 :: Int -> Int -> Int
add1 a b = a + b

add2 :: (Int,Int) -> Int
add2 (a,b) = a + b

inc :: Int -> Int
inc a = add1 1 a

inc2:: Int -> Int
inc2 a = add2 (1,a)

inc3:: Int -> Int
inc3 = add1 1
-----------------------------
-- my own datatype
data Day = Monday
         | Tuesday
         | Wednesday
         | Thursday
         | Friday
         | Saturday
         | Sunday
         deriving (Eq, Ord, Enum, Show)  --beide ableiten

--isWorkingday :: Day -> Bool
--isWorkingday x = (elem x [Tuesday..Friday])
isSunday :: Day -> Bool
isSunday Sunday = True
isSunday day = False

ranger a b = [a..b]

data Tree a = Leaf a
            | Branch (Tree a) (Tree a)
            deriving (Show)


instance Eq a => Eq (Tree a) where
  Leaf a       == Leaf b             = a == b
  Branch l1 r1 == Branch l2 r2       = l1==l2 && r1==r2
  _ == _                             = False

instance Ord a => Ord (Tree a) where
  Leaf a < Leaf b             = a < b
  Leaf _ < Branch _ _         = True
  Branch _ _ < Leaf _         = False
  Branch l1 r1 < Branch l2 r2 = (l1 < l2) && (r1 < r2)
  t1           <= t2          = t1 < t2 || t1 == t2

  Leaf a > Leaf b             = a > b
  Leaf _ > Branch _ _         = True
  Branch _ _  > Leaf _        = False
  Branch l1 r1 > Branch l2 r2 = (l1 > l2) && (r1 > r2)
  t1           >= t2          = t1 > t2 || t1 == t2

--More examples on Monads for testing monade algebra:
--Example exeptions:

--first define Termes to representfractions
data Term = Con Int
  | Div Term Term
  deriving (Show)




data M a = Raise Exception
  | Return a
type Exception = String

--Bsp: eval function

--old eval function
eval :: Term -> Int
eval (Con a) = a
eval (Div t u) = (eval t) `div` (eval u)

-------------------------------------------------------
--arrowtest
--state transformers: application that involve a threading of a state throw a function
-- Example for pointless style
add_func :: (a->Int) -> (a->Int) -> (a->Int)
add_func f g b = f b + g b

type State r i o = (r,i) -> (r,o)
--A generalization of State transformers
add_func_ST :: State a b Int -> State a b Int -> State a b Int
add_func_ST f g (s0,b) = let (s1, x) = f (s0,b)
                         in
                           let (s2, y) = g (s1,b)
                           in (s2,x+y)
