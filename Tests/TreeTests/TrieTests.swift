import XCTest
import os
@testable import Tree

/// Validation of `Trie`.
final class TrieTests: XCTestCase {
    private let fixture = TrieFixture()

    /// Validates that `init()` returns an empty trie.
    func test_init_() throws {
        let sut = fixture.makeEmptySUT()
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
    }

    /// Validates that `contains(collection:)` returns `false`
    /// if one element is not contained within the trie.
    func test_contains_false() throws {
        let sut = Trie<[String]>()

        let expectedCollection = fixture.letters
        let insertedCollection = Array(expectedCollection.dropLast())

        sut.insert(insertedCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.children.isEmpty)

        XCTAssertFalse(sut.contains(expectedCollection))
    }

    /// Validates that `contains(collection:)` returns `true`
    /// if one element is not contained within the trie.
    func test_contains_true() throws {
        let sut = Trie<[String]>()

        let expectedCollection = fixture.letters

        sut.insert(expectedCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.children.isEmpty)

        XCTAssertTrue(sut.contains(expectedCollection))
    }

    /// Validates that `count` works as expected.
    func test_count() throws {
        let sut = Trie<String>()
        XCTAssertEqual(sut.count, 0)

        let expectedCollections = ["A", "B", "C", "D"]
        let expectedCount = expectedCollections.count

        for item in expectedCollections {
            sut.insert(item)
        }

        XCTAssertEqual(sut.count, expectedCount)
    }

    /// Validates that `isEmpty` works as expected.
    func test_isEmpty() throws {
        let sut = Trie<String>()
        XCTAssertTrue(sut.isEmpty)

        let expectedCollections = ["A", "B", "C", "D"]
        let expectedCount = expectedCollections.count

        for item in expectedCollections {
            sut.insert(item)
        }

        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.count, expectedCount)
    }

    /// Validates that `insert(collection:)` does nothing when given an empty `collection`.
    func test_insert_empty_collection() throws {
        let sut = Trie<[String]>()
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)

        let expectedCollection = [String]()

        sut.insert(expectedCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertTrue(sut.root.isTerminating)
    }

    /// Validates that `insert(collection:)` works as expected
    /// when inserting the same collection twice into the trie.
    func test_insert_same_collection_twice() throws {
        let sut = Trie<String>()
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)

        let word = "CUT"

        sut.insert(word)

        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.children.isEmpty)

        sut.insert(word)

        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.children.isEmpty)
    }

    /// Validates that `insert(collection:)` works as expected.
    func test_insert_success() throws {
        let sut = Trie<[String]>()
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)

        let expectedCollection = fixture.letters

        sut.insert(expectedCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.children.isEmpty)
        XCTAssertEqual(sut.allCollections.count, 1)
    }

    /// Validates that `remove(collection:)` does nothing when given an empty collection.
    func test_remove_empty_collection() throws {
        let emptyCollection = [String]()

        let sut = Trie<[String]>()

        sut.insert(fixture.letters)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.isTerminating)
        XCTAssertFalse(sut.root.children.isEmpty)

        sut.remove(emptyCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.isTerminating)
        XCTAssertFalse(sut.root.children.isEmpty)
    }

    /// Validates that `remove(collection:)` does nothing when
    /// given a collection that has keys not found in the trie.
    func test_remove_with_key_not_in_trie() throws {
        let sut = Trie<[String]>()

        let insertedCollection = fixture.letters

        sut.insert(fixture.letters)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.isTerminating)
        XCTAssertFalse(sut.root.children.isEmpty)

        let extraText = "BOGUS"
        var toBeRemoved = insertedCollection
        toBeRemoved.append(extraText)
        toBeRemoved.shuffle()

        XCTAssertTrue(toBeRemoved.contains(extraText))
        XCTAssertFalse(insertedCollection.contains(extraText))

        sut.remove(toBeRemoved)
        XCTAssertTrue(sut.contains(insertedCollection))
    }

    /// Validates that `remove(collection:)` can successfully
    /// remove all of the elements currently in the trie.
    func test_remove_until_empty() throws {
        let sut = Trie<[String]>()

        let expectedCollection = fixture.letters

        sut.insert(expectedCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertFalse(sut.root.children.isEmpty)
        XCTAssertEqual(sut.allCollections.count, 1)

        sut.remove(expectedCollection)
        XCTAssertNil(sut.root.key)
        XCTAssertNil(sut.root.parent)
        XCTAssertTrue(sut.root.children.isEmpty)
        XCTAssertEqual(sut.allCollections.count, 0)
    }

    /// Validates that `collections(startingWith:)` returns an
    /// empty collection if `prefix` contains an unknown key.
    func test_collectionsStartingWith_returns_empty_collection() throws {
        let sut = fixture.makeWordsSUT()

        let bogusKey = "BOGUS"
        let result = sut.collections(startingWith: bogusKey)

        XCTAssertTrue(result.isEmpty)
    }

    /// Validates that `collections(startingWith:)` works as expected.
    func test_collectionsStartingWith_success() throws {
        let words = fixture.words
        let expectedResult = words.sorted()

        let sut = fixture.makeWordsSUT()

        let result = sut.collections(startingWith: "car")
        let sortedResult = result.sorted()

        XCTAssertEqual(sortedResult, expectedResult)
    }
}

struct TrieFixture {
    private let trieNodeFixture = TrieNodeFixture()

    var letters: [String] { ["L", "I", "S", "T"] }
    var words = ["car", "card", "care", "cared", "cars", "carbs", "carapace", "cargo"]

    func makeNode<T: Hashable>(key: T) -> TrieNode<T> {
        trieNodeFixture.makeSUT(key: key)
    }

    func makeEmptySUT() -> Trie<String> {
        Trie()
    }

    func makeWordsSUT() -> Trie<String> {
        let sut = makeEmptySUT()

        for word in words {
            sut.insert(word)
        }

        return sut
    }
}
