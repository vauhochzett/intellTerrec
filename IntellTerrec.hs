module IntellTerrec where

{- Idee: Terminlisten der Tutorgruppen aus TUMOnline herunterladen
 - und einlesen, beste Terminkombination nach folgenden Voraussetz-
 - ungen finden:
 - .. möglichst wenige Tage in der Uni
 - .. möglichst kurze Wartezeiten
 - .. möglichst kurze Laufwege -}


{- Typen -}

data Time = Time { startTime :: Integer, endTime :: Integer} -- Von, Bis
data Date = Date [(Integer, Time, Time)]


{- Kontanten -}

startTime1 :: Time
startTime1 = Time (12,30)

endTime1 :: Time
endTime1 = Time (14,00)

lv1 :: Date
lv1 = Date [(0, startTime1, endTime1)]


{- IO -}

-- to implement


{- Matching -}


