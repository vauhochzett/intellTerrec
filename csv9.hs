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

{-parseCSV :: String -> Either ParseError [[String]]
parseCSV input = parse csvFile "(unknown)" input

main =
    do c <- getContents
       case parse csvFile "(stdin)" c of
            Left e -> do putStrLn "Error parsing input:"
                         print e
            --Right r -> mapM_ print r
            Right r -> mapM_ print (extractInfo r)-}

-- parseTest :: String -> 


{- Extraktion der relevanten Informationen -}

extractInfo :: [[String]] -> GroupList -> GroupList
extractInfo csvInputs results
  | (length csvInputs) <= 1 = results
  | otherwise = extractInfo (tail csvInputs) (results ++ (helpMeExtract 0 (head (tail csvInputs)) [] dummyGroup))

helpMeExtract :: Integer -> [String] -> GroupList -> Group -> GroupList
helpMeExtract counter sublist results result
  | (length sublist) == 5 = results ++ [result]
  | counter == 0 = helpMeExtract 1 (tail sublist) results (Group "" (extractDay (head sublist)) dummyTime dummyTime )
  | counter == 2 = helpMeExtract 3 (tail sublist) results (Group "" (gday result) (extractTime (head sublist)) dummyTime)
  | counter == 3 = helpMeExtract 4 (tail sublist) results (Group "" (gday result)  (gstartTime result) (extractTime (head sublist)))
  | counter == 8 = helpMeExtract 9 (tail sublist) results (Group (head sublist) (gday result)  (gstartTime result) (gendTime result))
  | otherwise = helpMeExtract (counter+1) (tail sublist) results result

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

extractTime :: String -> Time
extractTime string = extractTimeHelper (words [ switchDD a | a <- string ])

extractTimeHelper :: [String] -> Time
extractTimeHelper timeString 
	| length timeString == 2 = Time (read (head timeString)) (read (last timeString))
	| otherwise = Time (read (head timeString)) (read (head (tail timeString)))

switchDD :: Char -> Char
switchDD character 
	| character == ':' = ' '
	| otherwise = character