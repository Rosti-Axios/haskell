import Data.Bits
import Data.Char
import Data.List
import Data.List.Split
import Data.Maybe
import qualified Data.ByteString.Char8 as B

-- TO CRACK
master_string = "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"

freqDict = ["th", "he", "an", "in", "er", "on", "re", "ed", "nd", "ha", "at", "en", "es", "of", "nt", "ea", "ti", "to", "io", "le", "is", "ou", "ar", "as", "de", "rt", "ve","the", "be", "to", "of", "and", "a", "in", "that", "have", "i","it", "for", "not", "on", "with", "he", "as", "you", "do", "at","this", "but", "his", "by", "from", "they", "we", "say", "her","she", "or", "an", "will", "my", "one", "all", "would", "there","their", "what", "so", "up", "out", "if", "about", "who", "get","which", "go", "me", "when", "make", "can", "like", "time", "no","just", "him", "know", "take", "people", "into", "year", "your","good", "some", "could", "them", "see", "other", "than", "then","now", "look", "only", "come", "its", "over", "think", "also","back", "after", "use", "two", "how", "our", "work", "first","well", "way", "even", "new", "want", "because", "any", "these","give", "day", "most", "us"]

hexToDigit = map digitToInt

digitToHex digit = (concat [['0'..'9'],['a'..'f']]) !! digit
hexByte hex = [digitToHex (shiftR hex 4)] ++ [digitToHex (hex .&. 15)]

xorDigit (x,y) = xor x y
xorBytes x y = xor x y

hexToPairDigit s = chunksOf 2 $ map digitToInt s 
combine [x,y] = shiftL x 4 + y
combineAllDigs digits = map combine digits
combineAllStrs string = map combine (hexToPairDigit string)

unionList:: [Bool] -> Bool
unionList [] = False
unionList (x:[]) = x
unionList (x:xs) = x || (unionList xs)

scoreList::[Bool] -> Int
scoreList [] = 0
scoreList (x:xs) 
	| x == True = 1 + scoreList xs
	| x == False = scoreList xs

tryAllByteKeys string = [score (decrypt string key) | key <- [0,1..127]]

comoIngles:: [Char] -> Bool
comoIngles charArray = unionList [isInfixOf key charArray | key <- freqDict]

score:: [Char] -> Int
score charArray = scoreList [isInfixOf key charArray | key <- freqDict]


-- mostLikelyKey :: [Char] -> Char
mostLikelyKey string = fromJust (elemIndex (maximum (tryAllByteKeys string)) (tryAllByteKeys string) ) 

findDecryption hex = decrypt (combineAllStrs hex) (mostLikelyKey (combineAllStrs hex))


decrypt string key = result
  where
    decrypted = map (\ e -> xor e key) string
    result = map chr decrypted

main = do
	print $ findDecryption master_string







