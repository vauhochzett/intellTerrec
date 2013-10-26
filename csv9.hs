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
            Right r -> mapM_ print r


{- Extraktion der relevanten Informationen -}

timeToDigits :: String -> [String]
timeToDigits string = words [ switchDD a | a <- string ]

extractTime :: [String] -> Time
extractTime timeString 
	| length timeString == 2 = Time (read (head timeString)) (read (last timeString))
	| otherwise = Time (read (head timeString)) (read (head (tail timeString)))

switchDD :: Char -> Char
switchDD character 
	| character == ':' = ' '
	| otherwise = character

extractDay :: String -> Day
extractDay string 
	| string == "MO" = 0
	| string == "DI" = 1
	| string == "MI" = 2
	| string == "DO" = 3
	| string == "FR" = 4