module PipeTake where

import Control.Monad (replicateM_)
import Pipes
import Prelude hiding (take)
import qualified Pipes.Prelude as P

--              +--------- A 'Pipe' that
--              |    +---- 'await's 'a's and
--              |    | +-- 'yield's 'a's
--              |    | |
--              v    v v
take ::  Int -> Pipe a a IO ()
take n = do
    replicateM_ n $ do                     -- Repeat this block 'n' times
        x <- await                         -- 'await' a value of type 'a'
        yield x                            -- 'yield' a value of type 'a'
    lift $ putStrLn "You shall not pass!"  -- Fly, you fools!

-- composing take n to limit the number of inputs
maxInput :: Int -> Producer String IO ()
maxInput n = P.stdinLn >-> take n

-- composing take n to limit the number of outputs
maxOutput :: Int -> Consumer String IO ()
maxOutput n = take n >-> P.stdoutLn
