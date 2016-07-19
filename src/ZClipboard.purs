module ZClipboard where

import Prelude

import Control.Monad.Eff (Eff)
import DOM.Node.Types (Element)

data Linked
data NotLinked

foreign import data ZCClient :: * -> *

foreign import data ZClipboard :: *

foreign import data ZCLIPBOARD :: !

foreign import setData
  :: forall eff
   . String
  -> String
  -> ZClipboard
  -> Eff (zClipboard :: ZCLIPBOARD | eff) ZClipboard

foreign import getData
  :: forall eff
   . String
  -> ZClipboard
  -> Eff (zClipboard :: ZCLIPBOARD | eff) String

foreign import clearData
  :: forall eff
   . String
  -> ZClipboard
  -> Eff (zClipboard :: ZCLIPBOARD | eff) Unit

foreign import init
  :: forall eff
   . Eff (zClipboard :: ZCLIPBOARD | eff) (ZCClient NotLinked)

foreign import clip
  :: forall eff
   . Element
  -> ZCClient NotLinked
  -> Eff (zClipboard :: ZCLIPBOARD | eff) (ZCClient Linked)

foreign import make
  :: forall eff
   . Element
  -> Eff (zClipboard :: ZCLIPBOARD | eff) (ZCClient Linked)

foreign import onCopy
  :: forall eff a
   . (ZClipboard -> Eff (zClipboard :: ZCLIPBOARD | eff) a)
  -> ZCClient Linked
  -> Eff (zClipboard :: ZCLIPBOARD | eff) (ZCClient Linked)
