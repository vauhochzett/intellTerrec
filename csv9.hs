module Csv9 where 
import Types
import Text.ParserCombinators.Parsec

--import Data.List

csvFile = endBy line eol
line = sepBy cell (char ',')
cell = quotedCell <|> many (noneOf ",\n\r")

quotedCell = 
    do char '"'
       content <- many quotedChar
       char '"' <?> "quote at end of cell"
       return content

quotedChar =
        noneOf "\""
    <|> try (string "\"\"" >> return '"')

eol =   try (string "\n\r")
    <|> try (string "\r\n")
    <|> string "\n"
    <|> string "\r"
    <?> "end of line"

parseCSV :: String -> Either ParseError [[String]]
parseCSV input = parse csvFile "(unknown)" input

main =
    do c <- getContents
       case parse csvFile "(stdin)" c of
            Left e -> do putStrLn "Error parsing input:"
                         print e
            --Right r -> mapM_ print r
            Right r -> mapM_ print (extractInfo r)

-- parseTest :: String -> 


{- Extraktion der relevanten Informationen -}

extractInfo :: [[String]] -> GroupList
extractInfo csvInput = [ Group group (extractDay day) (timeToDigits time1) (timeToDigits time2) | 
  (day, a, time1, time2, b, c, d, e, group, f, g, h, i, j) <- csvInput ]

--"DI","15.10.2013","10:15","11:45","90","220016771",
--"Tutorübungen zu Analysis für Informatik [MA0902]",
--"TT","Gruppe 17","MW 2235, Seminarraum (5502.02.235)",
--"Abhaltung","feststehender Termin","",""

extractDay :: String -> Day
extractDay string 
  | string == "MO" = 0
  | string == "DI" = 1
  | string == "MI" = 2
  | string == "DO" = 3
  | string == "FR" = 4

timeToDigits :: String -> Time
timeToDigits string = timeToDigits (words [ switchDD a | a <- string ])

extractTime :: [String] -> Time
extractTime timeString 
	| length timeString == 2 = Time (read (head timeString)) (read (last timeString))
	| otherwise = Time (read (head timeString)) (read (head (tail timeString)))

switchDD :: Char -> Char
switchDD character 
	| character == ':' = ' '
	| otherwise = character