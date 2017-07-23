module Echo where

import Control.Monad (unless)
import Control.Exception (try, throwIO)
import Pipes
import System.IO (isEOF)
import qualified GHC.IO.Exception as G

--         +--------+-- A 'Producer' that yields 'String's
--         |        |
--         |        |      +-- Every monad transformer has a base monad.
--         |        |      |   This time the base monad is 'IO'.
--         |        |      |  
--         |        |      |  +-- Every monadic action has a return value.
--         |        |      |  |   This action returns '()' when finished
--         v        v      v  v
stdinLn :: Producer String IO ()
stdinLn = do
    eof <- lift isEOF        -- 'lift' an 'IO' action from the base monad
    unless eof $ do
        str <- lift getLine
        yield str            -- 'yield' the 'String'
        stdinLn              -- Loop

loop :: Effect IO ()
loop = for stdinLn (lift . putStrLn)

triple :: Monad m => a -> Producer a m ()
triple x = do
    yield x
    yield x
    yield x

--          +--------+-- A 'Consumer' that awaits 'String's
--          |        |
--          v        v
stdoutLn :: Consumer String IO ()
stdoutLn = do
    str <- await  -- 'await' a 'String'
    x   <- lift $ try $ putStrLn str
    case x of
        -- Gracefully terminate if we got a broken pipe error
        Left e@(G.IOError { G.ioe_type = t}) ->
            lift $ unless (t == G.ResourceVanished) $ throwIO e
        -- Otherwise loop
        Right () -> stdoutLn

doubleUp :: Monad m => Consumer String m String
doubleUp = (++) <$> await <*> await
