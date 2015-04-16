module Control.UI.ZClipboard (
  ZCClient(),
  ZClipboard(),
  ZCLIPBOARD(),
  Linked(), NotLinked(), IsLinked,
  setData, getData, clearData,
  init, make, clip,
  onCopy
  ) where

import DOM
import Control.Monad.Eff
import Data.Tuple
import Data.Function
import Data.DOM.Simple.Types

data Linked
data NotLinked
class IsLinked a 

instance linkedIsLinked :: IsLinked Linked
instance notLinkedIsLinked :: IsLinked NotLinked


foreign import data ZCClient :: * -> *
foreign import data ZClipboard :: *
foreign import data ZCLIPBOARD :: ! 


foreign import setDataImpl """
function setDataImpl(clipboard, key, value) {
  return function() {
    clipboard.setData(key, value);
    return clipboard;
  };
}
""" :: forall e. Fn3 ZClipboard String String
       (Eff (zClipboard :: ZCLIPBOARD|e) ZClipboard)

setData :: forall e. String -> String -> ZClipboard -> 
           Eff (zClipboard :: ZCLIPBOARD|e) ZClipboard
setData key val clipboard = runFn3 setDataImpl clipboard key val

foreign import getDataImpl """
function getDataImpl(clipboard, key) {
  return function() {
    return clipboard.getData(key);
  };
}
""" :: forall e. Fn2 ZClipboard String
       (Eff (zClipboard :: ZCLIPBOARD|e) String)

getData :: forall e. String -> ZClipboard -> 
           Eff (zClipboard :: ZCLIPBOARD|e) String
getData key clipboard = runFn2 getDataImpl clipboard key

foreign import clearDataImpl """
function clearDataImpl(clipboard, key) {
  return function() {
    return clipboard.clearData(key);
  };
}
""" :: forall e. Fn2 ZClipboard String
       (Eff (zClipboard :: ZCLIPBOARD|e) Unit) 

clearData :: forall e. String -> ZClipboard -> 
             Eff (zClipboard :: ZCLIPBOARD|e) Unit
clearData key clipboard = runFn2 clearDataImpl clipboard key

foreign import init """
function init() {
  var ZC = require('zeroclipboard');
  return new ZC();
}
""" :: forall e. Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient NotLinked)


foreign import clip """
function clip(el) {
  return function(client) {
    return function() {
      client.clip(el);
      return client;
    };
  };
}
""" :: forall e. HTMLElement -> ZCClient NotLinked ->
       Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient Linked)

foreign import make """
function make(el) {
  return function() {
    var ZC = require('zeroclipboard');
    return new ZC(el);
  }
}
""" :: forall e. HTMLElement ->
       Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient Linked)


foreign import onCopy """
function onCopy(callback) {
  return function(client) {
    return function() {
      client.on('ready', function() {
        client.on('copy', function(event) {
          callback(event.clipboardData)();
        });
      });
      return client;
    };
  };
}
""" :: forall e a. (ZClipboard -> Eff (zClipboard :: ZCLIPBOARD|e) a) ->
       ZCClient Linked ->
       Eff (zClipboard :: ZCLIPBOARD|e) (ZCClient Linked)
