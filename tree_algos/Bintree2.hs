module Bintree2 where

data BTree = Empty | BBranch Int BTree BTree
  deriving (Eq, Show)
