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


{- Konstanten - Ziel: aus dem C#-IO-Programm erhalten -}

freeSlot :: DateList
freeSlot = 
	[Date 0 (Time 11 30) (Time 13 00), 
	Date 0 (Time 15 00) (Time 17 00),
	Date 0 (Time 19 00) (Time 23 00),
	Date 1 (Time 12 00) (Time 14 00),
	Date 3 (Time 10 30) (Time 15 00),
	Date 4 (Time 7 30) (Time 9 30)]

dummyTime :: Time
dummyTime = Time 10 00

dummyGroup :: Group
dummyGroup = (Group "" 0 dummyTime dummyTime)

inputStrings :: [[[String]]]
inputStrings = [inputStringAnalysis, inputStringTest]

inputStringTest :: [[String]]
inputStringTest = [[], ["DI","1.1.11","10:00","12:00","1","1","ABC","TT","Gruppe 99","abc","a","f","",""]]

inputStringAnalysis :: [[String]]
inputStringAnalysis = [["\65279\"WOCHENTAG\"","DATUM","VON","BIS","DAUER_IN_MINUTEN","LV_NUMMER","TITEL","LV_ART","LV_GRUPPE","ORT","EREIGNIS_TYP","TERMIN_TYP","VORTRAGENDER_KONTAKTPERSON","ANMERKUNG"],
	["DI","15.10.2013","10:15","11:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 17","MW 2235, Seminarraum (5502.02.235)","Abhaltung","feststehender Termin","",""],
	["DI","15.10.2013","12:15","13:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 2","03.06.011, Seminarraum (M6/M8) (5606.03.011)","Abhaltung","feststehender Termin","",""],
	["DI","15.10.2013","12:15","13:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 3","03.10.011, Seminarraum M4/M5/M13 (5610.03.011)","Abhaltung","feststehender Termin","",""],
	["DI","15.10.2013","12:15","13:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 1","02.13.010, Seminarraum (5613.02.010)","Abhaltung","feststehender Termin","",""],
	["DI","15.10.2013","12:15","13:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 11","03.08.011, Seminarraum (M1/M7) (5608.03.011)","Abhaltung","feststehender Termin","",""],
	["MI","16.10.2013","08:30","10:00","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 18","01.06.020, Seminarraum (5606.01.020)","Abhaltung","feststehender Termin","",""],
	["MI","16.10.2013","08:30","10:00","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 12","00.08.059, Tutor (5608.EG.059)","Abhaltung","feststehender Termin","",""],
	["MI","16.10.2013","14:15","15:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 15","MW 2050, Zeichen-/H\246rsaal (5510.02.050)","Abhaltung","feststehender Termin","",""],
	["MI","16.10.2013","14:15","15:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 13","01.06.020, Seminarraum (5606.01.020)","Abhaltung","feststehender Termin","",""],
	["DO","17.10.2013","10:15","11:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 5","MW 0234, Seminarraum (5502.EG.234)","Abhaltung","feststehender Termin","",""],
	["DO","17.10.2013","10:15","11:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 16","00.07.014, \220bungsraum (5607.EG.014)","Abhaltung","feststehender Termin","",""],
	["DO","17.10.2013","10:15","11:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 19","00.08.059, Tutor (5608.EG.059)","Abhaltung","feststehender Termin","",""],
	["DO","17.10.2013","12:00","13:30","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 6","MW 1250, H\246rsaal (5502.01.250)","Abhaltung","feststehender Termin","",""],
	["DO","17.10.2013","12:15","13:45","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 7","MW 0234, Seminarraum (5502.EG.234)","Abhaltung","feststehender Termin","",""],
	["FR","18.10.2013","08:30","10:00","90","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 8","MW 2235, Seminarraum (5502.02.235)","Abhaltung","feststehender Termin","",""],
	["FR","18.10.2013","14:15","16:00","105","220016771","Tutor\252bungen zu Analysis f\252r Informatik [MA0902]","TT","Gruppe 14","00.08.059, Tutor (5608.EG.059)","Abhaltung","feststehender Termin","",""]]