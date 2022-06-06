{-# LANGUAGE DataKinds #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE KindSignatures #-}

import Data.Kind (Type)

data Nat = Zero
           | Succ Nat

data Vec  :: Nat -> * -> * where
  Nil  :: Vec Zero a
  (:>) :: a -> Vec n a -> Vec (Succ n) a

type Matrix m n  a = Vec m (Vec n a)

sumi :: (Num a) => Vec n a -> a
sumi Nil = 0
sumi (x:>xs) = x + sumi xs

mapi :: (a->b) -> Vec n a -> Vec n b
mapi f Nil     = Nil
mapi f (x:>xs) = (f x) :> mapi f xs

zipWithi :: (a->b->c) -> Vec d a -> Vec d b -> Vec d c
zipWithi f Nil Nil = Nil
zipWithi f (x:>xs) (y:>ys) = ((f x y) :> (zipWithi f xs ys))

transpose :: Matrix m n a -> Matrix n m a
transpose (x :> Nil) = mapi (\ v -> (v:>Nil)) x 
transpose (x :> xs@( y:> ys)) = zipWithi (:>) x (transpose xs)

multiply :: (Num a) => Matrix d d a -> Matrix d d a -> Matrix d d a
multiply xm ym = mapi (\ x_row -> (mapi (\ y_column -> sumi (zipWithi (*) x_row y_column)) (transpose ym))) xm
