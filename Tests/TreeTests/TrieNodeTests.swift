import XCTest
import os
@testable import Tree

/// Validation of `TrieNode`.
final class TrieNodeTests: XCTestCase {
    private let fixture = TrieNodeFixture()

    /// Validates that `init(key:parent:)` properly captures default values for the parameters.
    func test_init_default_values() throws {
        let sut = fixture.makeEmptySUT()
        XCTAssertNil(sut.key)
        XCTAssertNil(sut.parent)
    }

    /// Validates that `init(key:parent:)` correctly captures the given parameters.
    func test_init_captures_parameters() throws {
        let expectedKey = "KEY"
        let expectedParentKey = "PARENT"
        let expectedParent = fixture.makeSUT(key: expectedParentKey)

        let sut = TrieNode(key: expectedKey, parent: expectedParent)

        XCTAssertEqual(sut.key, expectedKey)
        XCTAssertEqual(sut.parent?.key, expectedParentKey)
    }

    /// Validates that `set(isTerminating:)` works as expected.
    func test_setIsTerminating() throws {
        let sut = fixture.makeSUT(key: "A")
        XCTAssertFalse(sut.isTerminating)

        sut.set(isTerminating: true)
        XCTAssertTrue(sut.isTerminating)

        sut.set(isTerminating: false)
        XCTAssertFalse(sut.isTerminating)
    }

    /// Validates that `setChild(key:node:)` does nothing
    /// when the given `key` is not contained in the trie.
    func test_setChild_unknown_key() throws {
        let sut = fixture.makeEmptySUT()

        let expectedKey = "A"
        let expectedNode = fixture.makeSUT(key: expectedKey)
        XCTAssertEqual(expectedNode.key, expectedKey)

        let bogusKey = "BOGUS"
        sut.setChild(key: bogusKey, node: nil)

        XCTAssertEqual(expectedNode.key, expectedKey)
    }

    /// Validates that `setChild(key:node:)` is
    /// able to successfully set a child to `nil`.
    func test_setChild_to_nil() throws {
        let sut = fixture.makeEmptySUT()

        let expectedKey = "A"
        let expectedNode = fixture.makeSUT(key: expectedKey)
        XCTAssertEqual(expectedNode.key, expectedKey)

        sut.setChild(key: expectedKey, node: nil)

        XCTAssertNil(sut.children[expectedKey])
    }

    /// Validates that `setChild(key:node:)` works as expected.
    func test_setChild() throws {
        let sut = fixture.makeEmptySUT()
        XCTAssertNil(sut.key)
        XCTAssertTrue(sut.children.isEmpty)

        let expectedKey = "A"
        let expectedNode = fixture.makeSUT(key: expectedKey)
        XCTAssertEqual(expectedNode.key, expectedKey)

        sut.setChild(key: expectedKey, node: expectedNode)

        let childNode = try XCTUnwrap(sut.children[expectedKey])
        XCTAssertEqual(childNode.key, expectedKey)
    }
}

struct TrieNodeFixture {
    func makeEmptySUT() -> TrieNode<String> {
        TrieNode()
    }

    func makeSUT<T: Hashable>(key: T) -> TrieNode<T> {
        TrieNode(key: key)
    }
}
