module Control.UI.ZClipboard (
  ZCClient(),
  ZClipboard(),
  ZCLIPBOARD(),
  Linked(), NotLinked(), IsLinked,
  setData, getData, clearData,
  init, make, clip,
  onCopy
  ) where

import Prelude

import Control.Monad.Eff (Eff())
import Data.Function (Fn2(), Fn3(), runFn2, runFn3)
import DOM.Node.Types (Element())

data Linked
data NotLinked
class IsLinked a

instance linkedIsLinked :: IsLinked Linked
instance notLinkedIsLinked :: IsLinked NotLinked


foreign import data ZCClient :: * -> *
foreign import data ZClipboard :: *
foreign import data ZCLIPBOARD :: !


foreign import setDataImpl :: forall e. Fn3 ZClipboard String String
       (Eff (zClipboard :: ZCLIPBOARD|e) ZClipboard)

setData :: forall e. String -> String -> ZClipboard ->
           Eff (zClipboard :: ZCLIPBOARD|e) ZClipboard
setData key val clipboard = runFn3 setDataImpl clipboard key val

foreign import getDataImpl :: forall e. Fn2 ZClipboard String
       (Eff (zClipboard :: ZCLIPBOARD|e) String)

getData :: forall e. String -> ZClipboard ->
           Eff (zClipboard :: ZCLIPBOARD|e) String
getData key clipboard = runFn2 getDataImpl clipboard key

foreign import clearDataImpl :: forall e. Fn2 ZClipboard String
       (Eff (zClipboard :: ZCLIPBOARD|e) Unit)

clearData :: forall e. String -> ZClipboard ->
             Eff (zClipboard :: ZCLIPBOARD|e) Unit
clearData key clipboard = runFn2 clearDataImpl clipboard key

foreign import init :: forall e. Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient NotLinked)


foreign import clip :: forall e. Element -> ZCClient NotLinked ->
       Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient Linked)

foreign import make :: forall e. Element ->
       Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient Linked)


foreign import onCopy :: forall e a. (ZClipboard -> Eff (zClipboard :: ZCLIPBOARD|e) a) ->
       ZCClient Linked ->
       Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient Linked)
