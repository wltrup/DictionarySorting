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
                                                // dictionary, sorted in ascending order by their keys
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
    
    public func sorted(by sorter: ValueSorter) -> [Element]
    
}

extension Dictionary where Key: Comparable, Value: Comparable {
    
    public enum KeyValueSorter {
        case keysOnly(KeyOrder)
        case valuesThenKeys(values: ValueOrder, keys: KeyOrder)
    }
    
    public func sorted(by sorter: KeyValueSorter) -> [Element]
    
}
```

There are also some useful global functions: 
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

## Installation

**DictionarySorting** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## Author

Wagner Truppel, trupwl@gmail.com

## License

**DictionarySorting** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.
