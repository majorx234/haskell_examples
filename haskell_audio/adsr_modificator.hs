module Main where

adsr_func :: (Float,Float,Float,Float,Float) -> Float -> Float -> Float
adsr_func (numSamples,at,dt,st,rt) pos value |pos  < at * numSamples = value * (pos /(at * numSamples)) 
                                             |pos  < (at + dt) * numSamples = value * (1 - (0.7 * (pos - at * numSamples))/(dt * numSamples))
                                             |pos  < (at +dt + st) * numSamples = value * 0.3
                                             |otherwise = value * (0.3 - (0.3 * (pos-(at+dt+st) * numSamples))/(rt * numSamples))

adsrmap :: ((Float ,Float,Float,Float,Float) -> Float -> a -> b) -> [a]  -> (Float,Float,Float,Float,Float) -> Float -> [b]
adsrmap f [] _ _ = []
adsrmap f (x:xs) params pos  = ((f params pos x) : (adsrmap f xs params (pos + 1)))

adsrmap_akku :: ([Float],[Float],((Float,Float,Float,Float,Float) -> Float -> Float -> Float),(Float,Float,Float,Float,Float,Float)) -> [Float]
adsrmap_akku ([],out,_,_) = out
adsrmap_akku ((x:xs),ys,f,(numSamples,at,dt,st,rt,pos)) |pos == numSamples-1 = ((f (numSamples,at,dt,st,rt) pos x) : ys)
                                                         |otherwise = adsrmap_akku (xs,((f (numSamples,at,dt,st,rt) pos x) : ys),f,(numSamples,at,dt,st,rt,pos+1))

adsr_modificator :: (Float,Float,Float,Float) -> (Float,[Float]) -> [Float]
adsr_modificator (at, dt, st, rt) (numSamples, ls) =   reverse $ adsrmap_akku (ls, [], adsr_func, (numSamples,at,dt,st,rt, 0.0))

adsr_wrap :: (Float,Float,Float,Float) -> [Float] -> [Float]
adsr_wrap param (x:xs) = (x : (adsr_modificator param (x , xs))) 

main = interact $ unlines . map show . (adsr_wrap (0.1, 0.2, 0.4, 0.3)) . map read . words
