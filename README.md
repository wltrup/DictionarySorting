# DictionarySorting
![](https://img.shields.io/badge/platforms-iOS%2010%20%7C%20tvOS%2010%20%7C%20watchOS%204%20%7C%20macOS%2010.14-red)
[![Xcode](https://img.shields.io/badge/Xcode-11-blueviolet.svg)](https://developer.apple.com/xcode)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/wltrup/DictionarySorting)
![GitHub](https://img.shields.io/github/license/wltrup/DictionarySorting)

## What

**DictionarySorting** is a Swift Package Manager package for iOS/tvOS (10.0 and above), watchOS (4.0 and above), and macOS (10.14 and above), under Swift 5.0 and above,  implementing an extension to `Dictionary` that provides an easy-to-use and ergonomic "swifty" way to sort a dictionary, as easy as:

```swift
let data = /* ... */ // a dictionary of some kind
let sorted = data.sorted(by: .keys(.ascending)) // returns an array of the elements stored in the
                                                // dictionary, sorted in ascending order of their keys
```

The package provides several such ```sorted(by:)``` functions, depending on whether one or both the dictionary's `Key` and `Value` types conform to `Comparable`:

```swift
extension Dictionary where Key: Comparable {
    
    public typealias KeyOrder = SortOrder
    
    public enum KeySorter {
        case keys(KeyOrder)
    }
    
    public func sorted(by sorter: KeySorter) -> [Element]
    
}

extension Dictionary where Value: Comparable {
    
    public typealias ValueOrder = SortOrder
    
    public enum ValueSorter {
        case values(ValueOrder)
    }

    /// Keys will not be in a well-defined order.
    public func sorted(by sorter: ValueSorter) -> [Element]
    
}

extension Dictionary where Key: Comparable, Value: Comparable {
    
    public enum KeyValueSorter {
        case keysOnly(KeyOrder)
        case valuesOnly(ValueOrder) // Keys will not be in a well-defined order.
        case valuesThenKeys(values: ValueOrder, keys: KeyOrder)
    }

    public func sorted(by sorter: KeyValueSorter) -> [Element]
    
}
```

Note that sorting by values without also sorting by keys does not guarantee a stable order for the keys. For example, 
```swift
let data = [5: 70, 6: 70, 7: 60, 8: 50]
let valueSortedData = data.sorted(by: .valuesOnly(.ascending))
```
may result in *either* of these arrays:

```swift
[
    (key: 8, value: 50),
    (key: 7, value: 60),
    (key: 5, value: 70),
    (key: 6, value: 70),
]
```
and

```swift
[
    (key: 8, value: 50),
    (key: 7, value: 60),
    (key: 6, value: 70),
    (key: 5, value: 70),
]
```

The same is true with

```swift
let data = [5: 70, 6: 70, 7: 60, 8: 50]
let valueSortedData = data.sorted(by: .values(.ascending))
```

Note also that there's no option

```swift
case keysThenValues(keys: KeyOrder, values: ValueOrder)
```
in the `KeyValueSorter` enumeration

```swift
public enum KeyValueSorter {
    case keysOnly(KeyOrder)
    case valuesOnly(ValueOrder) // Keys will not be in a well-defined order.
    case valuesThenKeys(values: ValueOrder, keys: KeyOrder)
}
```
because the keys in a dictionary are guaranteed to be unique and, therefore, once the dictionary is sorted by its keys, its values will be fixed and their order can no longer change.

The package also provides some useful global functions: 
```swift
public func sort<K: Hashable & Comparable, V>(_ subseq: Dictionary<K, V>.SubSequence,
                                              _ sorter: Dictionary<K, V>.KeySorter)
    -> [Dictionary<K, V>.Element]

public func sort<K: Hashable & Comparable, V>(_ kvPairs: [Dictionary<K, V>.Element],
                                              _ sorter: Dictionary<K, V>.KeySorter)
    -> [Dictionary<K, V>.Element]

public func sort<K: Hashable, V: Comparable>(_ subseq: Dictionary<K, V>.SubSequence,
                                             _ sorter: Dictionary<K, V>.ValueSorter)
    -> [Dictionary<K, V>.Element]

public func sort<K: Hashable, V: Comparable>(_ kvPairs: [Dictionary<K, V>.Element],
                                             _ sorter: Dictionary<K, V>.ValueSorter)
    -> [Dictionary<K, V>.Element]

public func sort<K: Hashable & Comparable, V: Comparable>(_ subseq: Dictionary<K, V>.SubSequence,
                                                          _ sorter: Dictionary<K, V>.KeyValueSorter)
    -> [Dictionary<K, V>.Element]

public func sort<K: Hashable & Comparable, V: Comparable>(_ kvPairs: [Dictionary<K, V>.Element],
                                                          _ sorter: Dictionary<K, V>.KeyValueSorter)
    -> [Dictionary<K, V>.Element]
```

## Dependencies

**DictionarySorting** depends on two other libraries of mine, [**SortOrder**](https://github.com/wltrup/SortOrder.git) and [**DictionarySlicing**](https://github.com/wltrup/DictionarySlicing.git).

## Installation

**DictionarySorting** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## License

**DictionarySorting** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
