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
type GroupList = [(GNumber, Day, Time, Time)]

data Time = Time { hour :: Hour, minute :: Minute}
	deriving (Show)	-- Von, Bis


data DateList = DateList {dateList :: [(Day, Time, Time)]} 
	deriving (Show)

data GroupSlots = GroupSlots {groupList :: GroupList}
	deriving (Show)


{- Konstanten -}

freeSlot :: DateList
freeSlot = DateList [(0, Time 11 30, Time 13 00), (0, Time 15 00, Time 17 00),
	(0, Time 19 00, Time 24 00)]

groupSlot :: GroupSlots
groupSlot = GroupSlots [(1,0, Time 10 00, Time 12 00), 
	(2,0, Time 12 00, Time 14 00), (3,0, Time 19 00, Time 20 30)]


{- IO -}

-- to implement


{- Funktionen -}

subtractTimes :: Time -> Time -> Bool
subtractTimes time1 time2 = (hour time1) < (hour time2)

compareStartTime :: Time -> Time -> Bool
compareStartTime time1 time2 
	| hour time1 < hour time2 = True
	| hour time1 == hour time2 && minute time1 <= minute time2 = True
	| otherwise = False

compareEndTime :: Time -> Time -> Bool
compareEndTime time1 time2
	| hour time1 > hour time2 = True
	| hour time1 == hour time2 && minute time1 >= minute time2 = True
	| otherwise = False

algorithm :: DateList -> GroupSlots -> GroupList
algorithm freeSlots groupSlots = [(group, day, startTime, endTime) | (group, day, startTime, endTime) <- (groupList groupSlots), 
	(freeDay, startFreeTime, endFreeTime) <- (dateList freeSlots), freeDay == day && compareStartTime startFreeTime startTime 
	&& compareEndTime endFreeTime endTime]


