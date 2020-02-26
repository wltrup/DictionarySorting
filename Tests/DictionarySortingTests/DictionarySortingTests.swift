import XCTest
import SortOrder
@testable import DictionarySorting

final class DictionarySortingTests: XCTestCase {

    var data: [Int: Int] = [:]

    override func setUp() {
        (Int.random(in: 1 ... 5) ... Int.random(in: 10 ... 15))
            .forEach { self.data[$0] = Int.random(in: 50 ... 80) }
    }

    func test_sortingByKey() {
        for order: SortOrder in [.ascending, .descending] {
            let keys = order.isAscending
                ? data.keys.sorted(by: <)
                : data.keys.sorted(by: >)
            let expected = keys.map { ( key: $0, value: data[$0]! ) }
            let resulted = data.sorted(by: .keys(order))
            zip(resulted, expected).forEach { arg1, arg2 in
                XCTAssertTrue(arg1 == arg2)
            }
        }
    }

    func test_sortingByValue() {
        for order: SortOrder in [.ascending, .descending] {
            let expected = order.isAscending
                ? data.values.sorted(by: <)
                : data.values.sorted(by: >)
            let resulted = data
                .sorted(by: .values(order))
                .map { $0.value }
            zip(resulted, expected).forEach { arg1, arg2 in
                XCTAssertTrue(arg1 == arg2)
            }
        }
    }

    func test_sortingByKeyValue_keysOnly() {
        data = [1: 100, 2: 90, 3: 90, 4: 80, 5: 70, 6: 70, 7: 60, 8: 50]
        for keyOrder: SortOrder in [.ascending, .descending] {
            let expected: [(key: Int, value: Int)]
            switch keyOrder {
            case .ascending:
                expected = [
                    (key: 1, value: 100),
                    (key: 2, value: 90),
                    (key: 3, value: 90),
                    (key: 4, value: 80),
                    (key: 5, value: 70),
                    (key: 6, value: 70),
                    (key: 7, value: 60),
                    (key: 8, value: 50),
                ]
            case .descending:
                expected = [
                    (key: 8, value: 50),
                    (key: 7, value: 60),
                    (key: 6, value: 70),
                    (key: 5, value: 70),
                    (key: 4, value: 80),
                    (key: 3, value: 90),
                    (key: 2, value: 90),
                    (key: 1, value: 100),
                ]
            }
            let resulted = data.sorted(by: .keysOnly(keyOrder))
            zip(resulted, expected).forEach { arg1, arg2 in
                XCTAssertTrue(arg1 == arg2)
            }
        }
    }

    func test_sortingByKeyValue_valuesOnly() {
        data = [1: 100, 2: 90, 3: 90, 4: 80, 5: 70, 6: 70, 7: 60, 8: 50]
        for valueOrder: SortOrder in [.ascending, .descending] {
            let expected: [(key: Int, value: Int)]
            switch valueOrder {
            case .ascending:
                expected = [
                    (key: 8, value: 50),
                    (key: 7, value: 60),
                    (key: 5, value: 70),
                    (key: 6, value: 70),
                    (key: 4, value: 80),
                    (key: 2, value: 90),
                    (key: 3, value: 90),
                    (key: 1, value: 100),
                ]
            case .descending:
                expected = [
                    (key: 1, value: 100),
                    (key: 2, value: 90),
                    (key: 3, value: 90),
                    (key: 4, value: 80),
                    (key: 5, value: 70),
                    (key: 6, value: 70),
                    (key: 7, value: 60),
                    (key: 8, value: 50),
                ]
            }
            let resulted = data.sorted(by: .valuesOnly(valueOrder))
            zip(resulted, expected).forEach { arg1, arg2 in
                XCTAssertTrue(arg1.value == arg2.value)
            }
        }
    }

    func test_sortingByKeyValue_valuesThenKeys() {
        data = [1: 100, 2: 90, 3: 90, 4: 80, 5: 70, 6: 70, 7: 60, 8: 50]
        for valueOrder: SortOrder in [.ascending, .descending] {
            for keyOrder: SortOrder in [.ascending, .descending] {
                let expected: [(key: Int, value: Int)]
                switch (valueOrder, keyOrder) {
                case (.ascending, .ascending):
                    expected = [
                        (key: 8, value: 50),
                        (key: 7, value: 60),
                        (key: 5, value: 70),
                        (key: 6, value: 70),
                        (key: 4, value: 80),
                        (key: 2, value: 90),
                        (key: 3, value: 90),
                        (key: 1, value: 100),
                    ]
                case (.ascending, .descending):
                    expected = [
                        (key: 8, value: 50),
                        (key: 7, value: 60),
                        (key: 6, value: 70),
                        (key: 5, value: 70),
                        (key: 4, value: 80),
                        (key: 3, value: 90),
                        (key: 2, value: 90),
                        (key: 1, value: 100),
                    ]
                case (.descending, .ascending):
                    expected = [
                        (key: 1, value: 100),
                        (key: 2, value: 90),
                        (key: 3, value: 90),
                        (key: 4, value: 80),
                        (key: 5, value: 70),
                        (key: 6, value: 70),
                        (key: 7, value: 60),
                        (key: 8, value: 50),
                    ]
                case (.descending, .descending):
                    expected = [
                        (key: 1, value: 100),
                        (key: 3, value: 90),
                        (key: 2, value: 90),
                        (key: 4, value: 80),
                        (key: 6, value: 70),
                        (key: 5, value: 70),
                        (key: 7, value: 60),
                        (key: 8, value: 50),
                    ]
                }
                let resulted = data.sorted(by: .valuesThenKeys(values: valueOrder, keys: keyOrder))
                zip(resulted, expected).forEach { arg1, arg2 in
                    XCTAssertTrue(arg1 == arg2)
                }
            }
        }
    }

    // XXX Needs tests

    func test_sort_subseq_byKey() {}

    func test_sort_kvPairs_byKey() {}

    func test_sort_subseq_byValue() {}

    func test_sort_kvPairs_byValue() {}

    func test_sort_subseq_byKeyValue() {}

    func test_sort_kvPairs_byKeyValue() {}

}
