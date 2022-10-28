{-# LANGUAGE GADTs #-}

data Nat = Zero
           | Succ Nat

--data Zero
--data Succ a

data Vec n a where
  Vnil  :: Vec Zero a
  Vcons :: a -> Vec n a -> Vec (Succ n) a

