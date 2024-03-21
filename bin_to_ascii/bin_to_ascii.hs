module Main where

import Data.List
import Data.Function
import Text.Printf
import Data.Char (digitToInt)
import Data.Char (chr)

convert_bin_to_int :: String -> Int
convert_bin_to_int = foldr step 0
    where step x y = (+) (digitToInt x) ( (*) y 2 )


main :: IO ()
main = do
  file <- readFile "./bin.txt"
  print (map chr (map convert_bin_to_int (words file)) )

