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

    /// Validates that `insert(_ value:)` works as expected when inserting into an empty tree.
    func test_insert_into_empty_tree() throws {
        let expectedValue = 123

        var sut = fixture.makeEmptyBinarySearchTreeSUT()
        XCTAssertNil(sut.root)

        sut.insert(expectedValue)
        XCTAssertNotNil(sut.root)
        XCTAssertEqual(sut.root?.value, expectedValue)
    }

    /// Validates that `insert(_ value:)` works as expected when inserting
    /// consecutive values into a non-empty tree.
    func test_insert_all_right_children() throws {
        var sut = fixture.makeEmptyBinarySearchTreeSUT()

        var expectedArray = [Int]()
        for value in fixture.numbers {
            sut.insert(value)
            expectedArray.append(value)
        }

        XCTAssertNotNil(sut.root)

        var currentNode = sut.root
        var traversed = [Int]()
        while currentNode != nil {
            if let value = currentNode?.value {
                traversed.append(value)
            }
            currentNode = currentNode?.rightChild
        }
        XCTAssertEqual(traversed, expectedArray)
    }

    /// Validates that `insert(_ value:)` properly creates a binary search tree when given
    /// a series of numbers.
    func test_insert() throws {
        let expectedArray = fixture.treeNumbers.sorted()
        let sut = fixture.makeBinarySearchTreeNumbersSUT()
        
        XCTAssertNotNil(sut.root)
        
        var traversed = [Int]()
        let root = try XCTUnwrap(sut.root)
        root.traverseInOrder { traversed.append($0) }
        
        XCTAssertEqual(traversed, expectedArray)
    }
}

extension TreeFixture {
    var treeNumbers: [Int] {
        [40, 18, 77, 1, 20, 70, 105, 0, 25, 45, 88]
    }
    
    func makeEmptyBinarySearchTreeSUT() -> BinarySearchTree<Int> {
        BinarySearchTree()
    }
    
    func makeBinarySearchTreeSUT(value: Int) -> BinarySearchTree<Int> {
        BinarySearchTree(root: makeNodeSUT(value))
    }

    func makeBinarySearchTreeNumbersSUT() -> BinarySearchTree<Int> {
        makeBinarySearchTreeSUT(array: treeNumbers)
    }
    
    func makeBinarySearchTreeSUT(array: [Int]) -> BinarySearchTree<Int> {
        var sut = makeEmptyBinarySearchTreeSUT()

        for value in array {
            sut.insert(value)
        }

        return sut
    }
}
