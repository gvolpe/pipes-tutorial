module Unix where

import Control.Monad (forever)
import Pipes
import qualified Pipes.Prelude as P  -- Pipes.Prelude provides 'take', too
import Prelude hiding (head)

head :: Monad m => Int -> Pipe a a m ()
head = P.take

yes :: Monad m => Producer String m r
yes = forever $ yield "y"

start :: IO ()
start = runEffect $ yes >-> head 3 >-> P.stdoutLn
