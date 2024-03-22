module Main where

import Data.List
import Data.Function
import Text.Printf
import Data.Char (digitToInt)
import Data.Char (chr)

convert_bin_to_int :: String -> Int
convert_bin_to_int = foldr step 0
    where step x y = (+) (digitToInt x) ( (*) y 2 )

convert_bin_to_int2 :: String -> Int
convert_bin_to_int2 [] = 0
convert_bin_to_int2 (x : xs) = (digitToInt x) + 2 * convert_bin_to_int2 xs

convert_reverse_bin_to_int x = convert_bin_to_int (reverse x)

main :: IO ()
main = do
  file <- readFile "./bin.txt"
  print (map chr (map convert_reverse_bin_to_int (words file)) )

