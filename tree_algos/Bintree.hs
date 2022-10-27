module Bintree where

data Tree = Leaf Int | Branch Int Tree Tree 
  deriving (Eq,Show)
