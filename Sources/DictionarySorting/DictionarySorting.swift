import Foundation
import SortOrder
import DictionarySlicing

extension Dictionary where Key: Comparable {
    
    public typealias KeyOrder = SortOrder
    
    public enum KeySorter {
        case keys(KeyOrder)
    }
    
    public func sorted(by sorter: KeySorter) -> [Element] {
        switch sorter {
        case let .keys(order):
            return self.sorted(by: Dictionary.keySorter(order))
        }
    }
    
    static func keySorter(_ order: KeyOrder) -> ((Key, Value), (Key, Value)) -> Bool {
        
        return { arg1, arg2 in
            let (k1, _) = arg1
            let (k2, _) = arg2
            return (k1 < k2) == order.isAscending
        }
        
    }
    
}

extension Dictionary where Value: Comparable {
    
    public typealias ValueOrder = SortOrder
    
    public enum ValueSorter {
        case values(ValueOrder)
    }
    
    public func sorted(by sorter: ValueSorter) -> [Element] {
        switch sorter {
        case let .values(order):
            return self.sorted(by: Dictionary.valueSorter(order))
        }
    }
    
    static func valueSorter(_ order: ValueOrder) -> ((Key, Value), (Key, Value)) -> Bool {
        
        return { arg1, arg2 in
            let (_, v1) = arg1
            let (_, v2) = arg2
            if v1 < v2 { return order.isAscending }
            if v1 > v2 { return order.isDescending }
            return false
        }
        
    }
    
}

extension Dictionary where Key: Comparable, Value: Comparable {
    
    public enum KeyValueSorter {
        case keysOnly(KeyOrder)
        case valuesThenKeys(values: ValueOrder, keys: KeyOrder)
    }
    
    public func sorted(by sorter: KeyValueSorter) -> [Element] {
        switch sorter {
        case let .keysOnly(keyOrder):
            return self.sorted(by: Dictionary.sorter(byValueFirst: false,
                                                     keyOrder: keyOrder,
                                                     valueOrder: .ascending)) // valueOrder ignored
        case let .valuesThenKeys(valueOrder, keyOrder):
            return self.sorted(by: Dictionary.sorter(byValueFirst: true,
                                                     keyOrder: keyOrder,
                                                     valueOrder: valueOrder))
        }
    }
    
    static func sorter(byValueFirst: Bool, keyOrder: KeyOrder, valueOrder: ValueOrder) ->
        ((Key, Value), (Key, Value)) -> Bool {
            
            return { arg1, arg2 in
                let (k1, v1) = arg1
                let (k2, v2) = arg2
                if byValueFirst {
                    if v1 < v2 { return valueOrder.isAscending }
                    if v1 > v2 { return valueOrder.isDescending }
                }
                return (k1 < k2) == keyOrder.isAscending
            }
            
    }
    
}

public func sort<K: Hashable & Comparable, V>(_ subseq: Dictionary<K, V>.SubSequence,
                                              _ sorter: Dictionary<K, V>.KeySorter)
    -> [Dictionary<K, V>.Element] {
        return toDictionary(subseq).sorted(by: sorter)
}

public func sort<K: Hashable & Comparable, V>(_ kvPairs: [Dictionary<K, V>.Element],
                                              _ sorter: Dictionary<K, V>.KeySorter)
    -> [Dictionary<K, V>.Element] {
        return toDictionary(kvPairs).sorted(by: sorter)
}

public func sort<K: Hashable, V: Comparable>(_ subseq: Dictionary<K, V>.SubSequence,
                                             _ sorter: Dictionary<K, V>.ValueSorter)
    -> [Dictionary<K, V>.Element] {
        return toDictionary(subseq).sorted(by: sorter)
}

public func sort<K: Hashable, V: Comparable>(_ kvPairs: [Dictionary<K, V>.Element],
                                             _ sorter: Dictionary<K, V>.ValueSorter)
    -> [Dictionary<K, V>.Element] {
        return toDictionary(kvPairs).sorted(by: sorter)
}

public func sort<K: Hashable & Comparable, V: Comparable>(_ subseq: Dictionary<K, V>.SubSequence,
                                                          _ sorter: Dictionary<K, V>.KeyValueSorter)
    -> [Dictionary<K, V>.Element] {
        return toDictionary(subseq).sorted(by: sorter)
}

public func sort<K: Hashable & Comparable, V: Comparable>(_ kvPairs: [Dictionary<K, V>.Element],
                                                          _ sorter: Dictionary<K, V>.KeyValueSorter)
    -> [Dictionary<K, V>.Element] {
        return toDictionary(kvPairs).sorted(by: sorter)
}
