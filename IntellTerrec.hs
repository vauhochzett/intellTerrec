module IntellTerrec where

{- Idee: Terminlisten der Tutorgruppen aus TUMOnline herunterladen
 - und einlesen, beste Terminkombination nach folgenden Voraussetz-
 - ungen finden:
 - .. möglichst wenige Tage in der Uni
 - .. möglichst kurze Wartezeiten
 - .. möglichst kurze Laufwege -}


{- Typen -}

type Day = Integer
type Hour = Integer
type Minute = Integer
type GNumber = Integer

data Time = Time { hour :: Hour, minute :: Minute}
	deriving (Show)	-- Von, Bis


data Date = Date {datelist :: [(Day, Time, Time)]} 
	deriving (Show)

data GroupSlots = GroupSlots {groupList :: [(GNumber, Day, Time, Time)]}
	deriving (Show)


{- Kontanten -}
freeSlot :: Date
freeSlot = Date [(0, Time 11 30, Time 13 00), (0, Time 15 00, Time 17 00),
	(0, Time 19 00, Time 24 00)]

groupSlot


subtractTimes :: Time -> Time -> Bool
subtractTimes time1 time2 = (hour time1) < (hour time2)


{- IO -}

-- to implement


{- Matching -}


