## Module Control.UI.ZClipboard

#### `Linked`

``` purescript
data Linked
```

##### Instances
``` purescript
instance linkedIsLinked :: IsLinked Linked
```

#### `NotLinked`

``` purescript
data NotLinked
```

##### Instances
``` purescript
instance notLinkedIsLinked :: IsLinked NotLinked
```

#### `IsLinked`

``` purescript
class IsLinked a
```

##### Instances
``` purescript
instance linkedIsLinked :: IsLinked Linked
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


