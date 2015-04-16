# Module Documentation

## Module Control.UI.ZClipboard

#### `Linked`

``` purescript
data Linked
```


#### `NotLinked`

``` purescript
data NotLinked
```


#### `IsLinked`

``` purescript
class IsLinked a where
```


#### `linkedIsLinked`

``` purescript
instance linkedIsLinked :: IsLinked Linked
```


#### `notLinkedIsLinked`

``` purescript
instance notLinkedIsLinked :: IsLinked NotLinked
```


#### `ZCClient`

``` purescript
data ZCClient :: * -> *
```


#### `ZClipboard`

``` purescript
data ZClipboard :: *
```


#### `ZCLIPBOARD`

``` purescript
data ZCLIPBOARD :: !
```


#### `setData`

``` purescript
setData :: forall e. String -> String -> ZClipboard -> Eff (zClipboard :: ZCLIPBOARD | e) ZClipboard
```


#### `getData`

``` purescript
getData :: forall e. String -> ZClipboard -> Eff (zClipboard :: ZCLIPBOARD | e) String
```


#### `clearData`

``` purescript
clearData :: forall e. String -> ZClipboard -> Eff (zClipboard :: ZCLIPBOARD | e) Unit
```


#### `init`

``` purescript
init :: forall e. Eff (zClipboard :: ZCLIPBOARD | e) (ZCClient NotLinked)
```


#### `clip`

``` purescript
clip :: forall e. HTMLElement -> ZCClient NotLinked -> Eff (zClipboard :: ZCLIPBOARD | e) (ZCClient Linked)
```


#### `make`

``` purescript
make :: forall e. HTMLElement -> Eff (zClipboard :: ZCLIPBOARD | e) (ZCClient Linked)
```


#### `onCopy`

``` purescript
onCopy :: forall e a. (ZClipboard -> Eff (zClipboard :: ZCLIPBOARD | e) a) -> ZCClient Linked -> Eff (zClipboard :: ZCLIPBOARD | e) (ZCClient Linked)
```



## Module Main

#### `onLoad`

``` purescript
onLoad :: forall e. Eff (dom :: DOM | e) Unit -> Eff (dom :: DOM | e) Unit
```




