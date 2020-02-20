module Core where

data Color = Red | Green | Blue
  deriving Show

printColor :: Color -> IO ()
printColor = print
