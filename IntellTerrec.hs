module IntellTerrec where

{- Idee: Terminlisten der Tutorgruppen aus TUMOnline herunterladen
 - und einlesen, beste Terminkombination nach folgenden Voraussetz-
 - ungen finden:
 - .. möglichst wenige Tage in der Uni
 - .. möglichst kurze Wartezeiten
 - .. möglichst kurze Laufwege -}


{- Typen -}

type Hour = Integer
type Minute = Integer

data Time = Time { hour :: Hour, minute :: Minute}
	deriving (Show)	-- Von, Bis




{-data Date = Date {list :: [(Integer, Time, Time)]} 
	[(Integer, Time, Time)] deriving (Show)-}


{- Kontanten -}

startTime1 :: Time
startTime1 = Time 12 30

endTime1 :: Time
endTime1 = Time 14 00

subtractTimes :: Time -> Time -> Bool
subtractTimes time1 time2 = (hour time1) < (hour time2)


{- IO -}

-- to implement


{- Matching -}


