module Types where

{- Typen -}

type Day = Integer
type Hour = Integer
type Minute = Integer
type GNumber = String

type GroupList = [Group]
type DateList = [Date]


data Time = Time {hour :: Hour, minute :: Minute}
	deriving (Show)	-- Von, Bis

data Date = Date {dday :: Day, dstartTime :: Time, dendTime :: Time} 
	deriving (Show)

data Group = Group {gNumber :: GNumber, gday :: Day, gstartTime :: Time, gendTime :: Time}
	deriving (Show)