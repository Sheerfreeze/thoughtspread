module TS.Utils
    ( module Export
    , Club(..)
    , FStudent(..)
    , Student(..)
    , ClubMap
    , Result
    , failYaml
    , clubsToMap
    , clubsToPairs
    , grades
    , fromStudent
    , toStudent
    , CSubmission(..)
    , opLst
    ) where
import Data.IORef as Export
import Text.Blaze as Export
import Data.Maybe as Export (fromJust)
import Data.Text as Export (Text, pack, unpack)
--import Data.List as Export
import Data.Char as Export
import Data.Yaml as Export
import Yesod.Static as Export
import Database.Persist as Export
import Database.Persist.TH as Export
import Database.Persist.Sqlite as Export
import Control.Monad.Trans.Resource as Export (runResourceT)
import Control.Monad.Logger as Export (runStderrLoggingT)

import Control.Exception
import TS.App

--Funtions
failYaml :: Either t [t1] -> [t1]
failYaml val = case val of
    Right x -> x
    Left _ -> []

fromStudent :: Student -> FStudent
fromStudent s = FStudent
    (studentName s)
    (studentGrade s)
    (studentChoices s !! 0)
    (studentChoices s !! 1)
    (studentChoices s !! 2)

toStudent :: FStudent -> Student
toStudent s = Student
    (sN s)
    (sG s)
    [sC1 s, sC2 s, sC3 s]

clubsToMap :: [Club] -> ClubMap
clubsToMap = map (\(Club n mn mx) -> (n,(mn,mx)))

clubsToPairs :: ClubMap -> [(Text, Text)]
clubsToPairs clubLst = [(x,x) | x <- map fst clubLst]

grades :: [(Text, Int)]
grades = zip (map (pack . (++"th Grade") . show) [9..12]) [9..12]

opLst :: [(Text,Bool)]
opLst = [("Encrypt",True),("Decrypt",False)]
