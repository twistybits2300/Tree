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
    
    /// Validates that `contains(_ value:)` returns `false` when the tree is empty.
    func test_contains_false_empty_tree() throws {
        let index = fixture.treeNumbers.count / 2
        let searchValue = fixture.treeNumbers[index]
        let sut = fixture.makeEmptyBinarySearchTreeSUT()
        XCTAssertFalse(sut.contains(searchValue))
    }

    /// Validates that `contains(_ value:)` returns `false` when
    /// the provided value is not contained by the tree.
    func test_contains_false() throws {
        let sut = fixture.makeBinarySearchTreeNumbersSUT()
        XCTAssertFalse(sut.contains(12345))
    }

    /// Validates that `contains(_ value:)` returns `true`
    /// when the given value is contained by the tree.
    func test_contains_true() throws {
        let index = fixture.treeNumbers.count / 2
        let searchValue = fixture.treeNumbers[index]
        let sut = fixture.makeBinarySearchTreeNumbersSUT()
        XCTAssertTrue(sut.contains(searchValue))
    }
    
    /// Validates that `remove(_ value:)` does nothing to an empty tree.
    func test_remove_from_empty_tree() throws {
        var sut = fixture.makeEmptyBinarySearchTreeSUT()
        sut.remove(12345)
        XCTAssertNil(sut.root)
    }

    /// Validates that after a `remove(_ value:)` from a tree with only one element
    /// the remaining tree is empty.
    func test_remove_from_one_element_tree() throws {
        let number = 12345
        var sut = fixture.makeBinarySearchTreeSUT(value: number)
        sut.remove(number)
        XCTAssertNil(sut.root)
    }

    /// Validates that `remove(_ value:)` leaves a properly balanced tree.
    func test_remove_leaves_balanced_tree() throws {
        var sut = fixture.makeComplexBinarySearchTreeNumbersSUT()
        XCTAssertNotNil(sut.root)

        let valueToRemove = 25
        sut.remove(valueToRemove)

        XCTAssertNotNil(sut.root)
        XCTAssertFalse(sut.contains(valueToRemove))

        var expectedArray = fixture.complexTreeNumbers.sorted()
        let index = try XCTUnwrap(expectedArray.firstIndex(of: valueToRemove))
        expectedArray.remove(at: index)
        XCTAssertFalse(expectedArray.contains(where: { $0 == valueToRemove }))

        var traversed = [Int]()
        let root = try XCTUnwrap(sut.root)
        root.traverseInOrder { traversed.append($0) }

        XCTAssertEqual(traversed, expectedArray)
    }
    
    /// Validates that `remove(_ value:)` leaves a properly balanced tree.
    func test_remove_more_complex_tree() throws {
        let extraValueLeft = 8
        let extraValueRight = 23

        var sut = fixture.makeComplexBinarySearchTreeNumbersSUT()
        sut.insert(extraValueLeft)
        sut.insert(extraValueRight)

        XCTAssertNotNil(sut.root)

        let valueToRemove1 = 17
        sut.remove(valueToRemove1)

        XCTAssertNotNil(sut.root)
        XCTAssertFalse(sut.contains(valueToRemove1))

        let valueToRemove2 = 10
        sut.remove(valueToRemove2)

        XCTAssertNotNil(sut.root)
        XCTAssertFalse(sut.contains(valueToRemove2))

        var expectedArray = fixture.complexTreeNumbers
        expectedArray.append(contentsOf: [extraValueLeft, extraValueRight])
        expectedArray.sort()

        var index = try XCTUnwrap(expectedArray.firstIndex(of: valueToRemove1))
        expectedArray.remove(at: index)
        XCTAssertFalse(expectedArray.contains(where: { $0 == valueToRemove1 }))

        index = try XCTUnwrap(expectedArray.firstIndex(of: valueToRemove2))
        expectedArray.remove(at: index)
        XCTAssertFalse(expectedArray.contains(where: { $0 == valueToRemove2 }))

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

    var complexTreeNumbers: [Int] {
        [
            50, 25, 75, 12, 37, 63, 87, 10, 17, 32, 45, 27, 33
        ]
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
    
    func makeComplexBinarySearchTreeNumbersSUT() -> BinarySearchTree<Int> {
        makeBinarySearchTreeSUT(array: complexTreeNumbers)
    }
    
    func makeBinarySearchTreeSUT(array: [Int]) -> BinarySearchTree<Int> {
        var sut = makeEmptyBinarySearchTreeSUT()

        for value in array {
            sut.insert(value)
        }

        return sut
    }
}
