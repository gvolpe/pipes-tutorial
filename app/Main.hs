module Main where

import Control.Applicative ((<$))  -- (<$) modifies return values
import Echo
import PipeTake
import Pipes
import Unix (start)
import qualified Pipes.Prelude as P  -- Pipes.Prelude already has 'stdinLn'
import System.IO

main :: IO ()
main = start
--main = runEffect $ maxInput 3 >-> P.stdoutLn

--main = do
--    hSetBuffering stdout NoBuffering
--    str <- runEffect $
--        ("End of input!" <$ P.stdinLn) >-> ("Broken pipe!" <$ P.stdoutLn)
--    hPutStrLn stderr str

--main = runEffect $ P.stdinLn >-> P.stdoutLn -- connecting producer and consumer using >-> (pipe)
--main = runEffect $ lift getLine >~ doubleUp >~ stdoutLn -- composing two consumers
--main = runEffect $ lift getLine >~ stdoutLn -- >~ (feed) stdoutLn (the consumer)
--main = runEffect $ for P.stdinLn (triple ~> lift . putStrLn) -- composing streaming transformations usin ~> (into)
--main = runEffect $ for stdinLn (lift . putStrLn) -- iterating over the results of stdinLn (the producer) generating an Effect
--main = runEffect loop
