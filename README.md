pipes-tutorial
==============

### Notes:
- `Producers` form the Generator category (`yield` and `~>`). 
- `Consumers` form the Iteratee category (`>~` and `await`).
- `Pipes` form the Unix pipes category (`>->` and `cat`).

### Types

Listed below, the supported types by Pipes for further reference:

```haskell
type Effect             = Proxy X  () () X
type Producer         b = Proxy X  () () b
type Consumer    a      = Proxy () a  () X
type Pipe        a    b = Proxy () a  () b

type Server        b' b = Proxy X  () b' b 
type Client   a' a      = Proxy a' a  () X

type Effect'            m r = forall x' x y' y . Proxy x' x y' y m r
type Producer'        b m r = forall x' x      . Proxy x' x () b m r
type Consumer'   a      m r = forall      y' y . Proxy () a y' y m r

type Server'       b' b m r = forall x' x      . Proxy x' x b' b m r
type Client'  a' a      m r = forall      y' y . Proxy a' a y' y m r
```

[https://hackage.haskell.org/package/pipes-4.3.4/docs/Pipes-Tutorial.html](https://hackage.haskell.org/package/pipes-4.3.4/docs/Pipes-Tutorial.html)
