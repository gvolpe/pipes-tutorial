module Transformers where

import Pipes
import qualified Pipes.Prelude as P

pair :: ListT IO (Int, Int)
pair = do
    x <- Select $ each [1, 2]
    lift $ putStrLn $ "x = " ++ show x
    y <- Select $ each [3, 4]
    lift $ putStrLn $ "y = " ++ show y
    return (x, y)

input :: Producer String IO ()
input = P.stdinLn >-> P.takeWhile (/= "quit")

name :: ListT IO String
name = do
    firstName <- Select input
    lastName  <- Select input
    return (firstName ++ " " ++ lastName)

start :: IO ()
start = runEffect $ every name >-> P.stdoutLn
--start = runEffect $ for (every pair) (lift . print)
-- Same as: runEffect $ every pair >-> P.print
