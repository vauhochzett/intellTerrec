module IntellTerrec where
import Csv9

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

type GroupList = [Group]
type DateList = [Date]


data Time = Time {hour :: Hour, minute :: Minute}
	deriving (Show)	-- Von, Bis

data Date = Date {dday :: Day, dstartTime :: Time, dendTime :: Time} 
	deriving (Show)

data Group = Group {gNumber :: GNumber, gday :: Day, gstartTime :: Time, gendTime :: Time}
	deriving (Show)


{- Konstanten (Testing) -}

freeSlot :: DateList
freeSlot = 
	[Date 0 (Time 11 30) (Time 13 00), 
	Date 0 (Time 15 00) (Time 17 00),
	Date 0 (Time 19 00) (Time 23 00)]

groupSlot :: GroupList
groupSlot = 
	[Group 1 0 (Time 11 15) (Time 12 45), 
	Group 2 0 (Time 12 00) (Time 13 30), 
	Group 3 0 (Time 19 00) (Time 20 30)]


{- IO -}

-- todo - implement


{- Funktionen -}

algorithm :: DateList -> GroupList -> GroupList
algorithm freeSlots groupSlots
	| length (match_1 freeSlots groupSlots) > 0 = match_1 freeSlots groupSlots
	| length (match_2 15 freeSlots groupSlots) > 0 = match_2 15 freeSlots groupSlots
	| length (match_2 30 freeSlots groupSlots) > 0 = match_2 30 freeSlots groupSlots
	| otherwise = undefined


match_1 :: DateList -> GroupList -> GroupList
match_1 freeSlots groupSlots = [ gs | gs <- groupSlots, fs <- freeSlots, 
	(dday fs == gday gs) && (startWithin (dstartTime fs) (gstartTime gs)) && (endWithin (dendTime fs) (gendTime gs)) ]

match_2 :: Integer -> DateList -> GroupList -> GroupList -- todo
match_2 amount freeSlots groupSlots = match_1 (expandSlots amount freeSlots) groupSlots


startWithin :: Time -> Time -> Bool
startWithin ftime gtime
	| hour ftime < hour gtime = True
	| hour ftime == hour gtime && minute ftime <= minute gtime = True
	| otherwise = False

endWithin :: Time -> Time -> Bool
endWithin ftime gtime
	| hour ftime > hour gtime = True
	| hour ftime == hour gtime && minute ftime >= minute gtime = True
	| otherwise = False


-- Zeitslots erweitern

expandSlots :: Integer -> DateList -> DateList -- Integer ist die Menge der Minuten (sollte nur 15 und 30 sein)
expandSlots amount freeSlots = [ Date (dday fs) (expandStartTime amount (dstartTime fs)) (expandEndTime amount (dendTime fs)) | fs <- freeSlots ]

expandStartTime :: Integer -> Time -> Time
expandStartTime amount time
	| minute time >= amount = Time (hour time) ((minute time)-amount)
	| otherwise = Time ((hour time)-1) ((minute time)+(60-amount))

expandEndTime :: Integer -> Time -> Time
expandEndTime amount time
	| minute time <= amount = Time (hour time) ((minute time)+amount)
	| otherwise = Time ((hour time)+1) ((minute time)-(60-amount))