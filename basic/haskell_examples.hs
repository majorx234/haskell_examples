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


-- own list implementation
-- TODO derive from own type class
data MyList a b = Nil | Cons a b (MyList a b)

is_null :: MyList a b -> Bool
is_null Nil = True
is_null _ = False

my_head :: MyList a b -> a
my_head ( Cons a b _) = a
my_head _ = error "empty list"

my_tail :: MyList a b -> MyList a b
my_tail ( Cons _ _ r) = r
my_tail Nil = error "tail auf leerer Liste "

my_concat :: (Num b) => MyList a b -> MyList a b -> MyList a b
my_concat Nil x = x
my_concat (Cons a b r) x = Cons a (b + 1) (my_concat r x)

my_map :: (a -> c) -> MyList a b -> MyList c b
my_map _ Nil = Nil
my_map f ( Cons a b r) = Cons (f a) b (my_map f r)

my_length :: (Num b) => MyList a b -> b
my_length Nil = 0
my_length (Cons a b r) = b

add_my_list :: (Num b) => a -> MyList a b -> MyList a b
add_my_list x Nil = Cons x 1 Nil
add_my_list x (Cons a b rest) = Cons x (b + 1) (Cons a b rest)

habs_my_list :: MyList a b -> (a, MyList a b)
habs_my_list Nil = error "list empty"
habs_my_list (Cons a b rest) = (a, rest)

generate_my_list_from_list :: (Foldable t, Num b) => t a -> MyList a b
generate_my_list_from_list ls = foldr add_my_list Nil ls

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
