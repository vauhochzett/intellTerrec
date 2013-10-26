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

type GroupList = [Group]
type DateList = [Date]


data Time = Time {hour :: Hour, minute :: Minute}
	deriving (Show)	-- Von, Bis

data Date = Date {dday :: Day, dstartTime :: Time, dendTime :: Time} 
	deriving (Show)

data Group = Group {gNumber :: GNumber, gday :: Day, gstartTime :: Time, gendTime :: Time}
	deriving (Show)


{- Konstanten -}

freeSlot :: DateList
freeSlot = 
	[Date 0 (Time 11 30) (Time 13 00), 
	Date 0 (Time 15 00) (Time 17 00),
	Date 0 (Time 19 00) (Time 24 00)]

groupSlot :: GroupList
groupSlot = 
	[Group 1 0 (Time 10 00) (Time 12 00), 
	Group 2 0 (Time 12 00) (Time 14 00), 
	Group 3 0 (Time 19 00) (Time 20 30)]


{- IO -}

-- todo - implement


{- Funktionen -}

algorithm :: DateList -> GroupList -> GroupList
algorithm freeSlots groupSlots
	| length (match_1 freeSlots groupSlots) > 0 = match_1 freeSlots groupSlots
	| length (match_2 freeSlots groupSlots) > 0 = match_2 freeSlots groupSlots
	| length (match_3 freeSlots groupSlots) > 0 = match_3 freeSlots groupSlots
	| otherwise = undefined


match_1 :: DateList -> GroupList -> GroupList
match_1 freeSlots groupSlots = [ gs | gs <- groupSlots, fs <- freeSlots, 
	(dday fs == gday gs) && (startWithin (dstartTime fs) (gstartTime gs)) && (endWithin (dendTime fs) (gendTime gs)) ]

match_2 :: DateList -> GroupList -> GroupList
match_2 freeSlots groupSlots = [ gs | gs <- groupSlots, fs <- freeSlots,
	(dday fs == gday gs) && (startWithin15 (dstartTime fs) (gstartTime gs)) && (endWithin (dendTime fs) (gendTime gs)) ]

-- todo
match_3 :: DateList -> GroupList -> GroupList
match_3 freeSlots groupSlots = undefined

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

expandSlots :: Integer -> DateList -> DateList -- Integer ist die Menge der Minuten (sollte nur 15 und 30 sein)
expandSlots amount freeSlots
	| = [Date (dday freeSlots) ((dstartTime freeSlots))