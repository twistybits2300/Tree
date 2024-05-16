import XCTest
import os
@testable import Tree

/// Validation of `BinarySearchTree`.
final class BinarySearchTreeTests: XCTestCase {
    private let fixture = TreeFixture()

    /// Validates that `init()` sets the `root` node to `nil`.
    func test_init() throws {
        let sut = fixture.makeEmptyBinarySearchTreeSUT()
        XCTAssertNil(sut.root)
    }
    
    /// Validates that `init(root:)` correctly captures the given `root` node.
    func test_initRoot() throws {
        let rootValue = fixture.randomNumber
        let sut = fixture.makeBinarySearchTreeSUT(value: rootValue)
        XCTAssertEqual(sut.root?.value, rootValue)
    }
}

extension TreeFixture {
    func makeEmptyBinarySearchTreeSUT() -> BinarySearchTree<Int> {
        BinarySearchTree()
    }
    
    func makeBinarySearchTreeSUT(value: Int) -> BinarySearchTree<Int> {
        BinarySearchTree(root: makeNodeSUT(value))
    }
}
