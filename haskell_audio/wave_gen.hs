module Main where

import System.Environment   
import Data.List  

type Pulse = Float
type Seconds = Float
type Samples = Float

sample_rate :: Samples
sample_rate = 48000.0

sin_wave :: Float -> Float -> Samples -> (Samples,[Float])
sin_wave pitch duration fs = (fs * duration , map sin $ map (*step) [0.0, 1 .. fs * duration-1])
                             where
                               step = (pitch * 2 *pi)/fs

saw_func :: (Fractional a, RealFrac a) => a -> a
saw_func x = x - fromIntegral (round (x - 0.5))

saw_wave :: Float -> Float -> Samples -> (Samples,[Float])
saw_wave pitch duration fs = (fs * duration , map saw_func $ map (*step) [0.0, 1/fs .. duration-1/fs])
                              where
                                step = pitch

gen_wave :: String -> [Float] -> [Samples]
gen_wave wave_form (pitch:duration:_) |wave_form == "sin" = let (x,xs) = sin_wave pitch duration sample_rate in (x:xs)
                                       | wave_form == "saw" = let (x,xs) = saw_wave pitch duration sample_rate in (x:xs)
                                       |otherwise = (sample_rate * duration : map (0 *)[0.. sample_rate*duration] )

main :: IO ()
main = do  
    (wave_str:wave_params) <- getArgs
    putStr $ unlines . map show $ gen_wave wave_str (map read wave_params)
