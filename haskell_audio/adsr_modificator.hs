---module Main where

adsr_func :: (Float,Float,Float,Float,Float,Float) -> Float -> Float
adsr_func (numSamples,at,dt,st,rt,pos) value |pos  < at * numSamples = value * (pos /(at * numSamples)) 
                                             |pos  < (at + dt) * numSamples = value * (1 - (0.7 * (pos - at * numSamples))/(dt * numSamples))
                                             |pos  < (at +dt + st) * numSamples = 0.3
                                             |otherwise = (0.3 - (0.3 * (pos-(at+dt+st) * numSamples))/(rt * numSamples))

---            f [samples] (numSamples)
adsrmap :: ((Float ,Float,Float,Float,Float,Float) -> a -> b) -> [a]  -> (Float,Float,Float,Float,Float,Float) -> [b]
adsrmap f [] _ = []
adsrmap f (x:xs) (numSamples,at,dt,st,rt,pos)  = ((f (numSamples,at,dt,st,rt,pos) x) : (adsrmap f xs (numSamples,at,dt,st,rt,pos + 1)))

adsrmap_akku :: ([Float],[Float],((Float,Float,Float,Float,Float,Float) -> Float -> Float),(Float,Float,Float,Float,Float,Float)) -> [Float]
adsrmap_akku ([],out,_,_) = out
adsrmap_akku ((x:xs),ys,f,(numSamples,at,dt,st,rt,pos)) |pos == numSamples-1 = ((f (numSamples,at,dt,st,rt,pos) x) : ys)
                                                         |otherwise = adsrmap_akku (xs,((f (numSamples,at,dt,st,rt,pos) x) : ys),f,(numSamples,at,dt,st,rt,pos+1))




adsr_modificator (at, dt, st, rt) (numSamples, ls) = reverse $ adsrmap_akku (ls, [], adsr_func, ((fromInteger numSamples),at,dt,st,rt, 0.0)) 


---main = interact $ unlines . map show . gen_wave "sin" . map read . words
--- main = unlines $ map show $ gen_wave "sin" $ map read $ words 
--- main = interact $ unlines . map show . gen_wave "sin" . map read . words
--- unline . map show .
---  print $ gen_wave "saw" 200.0 1.0
