import Data.Maybe

bisection :: (Double -> Double) -> Double -> Double -> Double -> Maybe Double
bisection f a b err 
	| (b-a)/2 < err = Just mid
	| f(mid) == 0 = Just mid
	| (f a) * (f mid) > 0 = bisection f mid b err
	| (f a) * (f mid) <= 0 = bisection f a mid err
	| otherwise = Nothing 
		where mid = (a+b)/2

newton_raphson :: (Double -> Double) -> (Double -> Double) -> Double -> Double -> Double
newton_raphson f fp x err
	| (f x) == 0 = x
	| (f xk) < err = xk
	| otherwise = newton_raphson f fp xk err
		where xk = x - (f x)/(fp x)

secant :: (Double -> Double) -> Double -> Double -> Double -> Double
--secant' = observe "Informative name for secnat" secant
secant f xk_1 xk_2 err 
	| (f xk_1) == 0 = xk_1
	| (f xk) < err = xk
	| otherwise = secant f xk xk_1 err
		where xk = xk_1 - (f xk_1) * ((xk_1 - xk_2) / ((f xk_1) - (f xk_2)))

horner :: Double -> [Double] -> Double
horner x = foldr (\a b -> a +b*x) 0

e :: Double
e = 2.7182818284590452353602874713527
main :: IO()
main = do
	let f x = e**x + x
	let fp x = e**x + 1
	let err = 10**(-15)
	print $ fromJust $ bisection f (-1.0) 1.0 err
	print $ newton_raphson f fp 1 err
	print $ secant f 1 0 err
	print $ fromJust $ bisection atan (-4.9) 5.1 err