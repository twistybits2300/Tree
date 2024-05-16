import XCTest
import os
@testable import Tree

/// Validation of `AVLTree`.
final class AVLTreeTests: XCTestCase {
    private let fixture = AVLTreeFixture()

    /// Validates that `rotateLeft(node:)` returns `nil`
    /// if the node's `rightChild` is `nil`.
    func test_rotateLeft_returns_nil() throws {
        let rightNode = fixture.makeNode(value: 234)
        let sut = fixture.makeSUT(value: 123)
        sut.root?.rightChild = rightNode
        XCTAssertNil(sut.rotateLeft(rightNode))
    }

    /// Validates that `rotateLeft(node:)` works as expected.
    func test_rotateLeft_success() throws {
        let nodeA = fixture.makeNode(value: "A")
        let nodeB = fixture.makeNode(value: "B")
        let nodeZ = fixture.makeNode(value: "Z")
        let nodeY = fixture.makeNode(value: "Y")
        let nodeC = fixture.makeNode(value: "C")
        let nodeD = fixture.makeNode(value: "D")
        let nodeX = fixture.makeNode(value: "X")

        nodeY.leftChild = nodeB
        nodeY.rightChild = nodeZ

        nodeZ.leftChild = nodeC
        nodeZ.rightChild = nodeD

        nodeX.leftChild = nodeA
        nodeX.rightChild = nodeY

        let sut = fixture.makeSUT(root: nodeX)
        let returnedNode = try XCTUnwrap(sut.rotateLeft(nodeX))

        let expectedArray = ["Y", "X", "A", "B", "Z", "C", "D"]
        var traversedArray = [String]()

        returnedNode.traversePreOrder {
            traversedArray.append($0)
        }

        XCTAssertEqual(traversedArray, expectedArray)
    }

    /// Validates that `rotateRight(node:)` returns `nil`
    /// if the `node`'s `leftChild` is `nil`.
    func test_rotateRight_returns_nil() throws {
        let leftNode = fixture.makeNode(value: 456)
        let root = fixture.makeNode(value: 567)
        root.leftChild = leftNode

        let sut = fixture.makeSUT(root: root)
        XCTAssertNil(sut.rotateRight(leftNode))
    }

    /// Validates that `rotateRight(node:)` works as expected.
    func test_rotateRight_success() throws {
        let nodeA = fixture.makeNode(value: "A")
        let nodeB = fixture.makeNode(value: "B")
        let nodeZ = fixture.makeNode(value: "Z")
        let nodeC = fixture.makeNode(value: "C")
        let nodeY = fixture.makeNode(value: "Y")
        let nodeD = fixture.makeNode(value: "D")
        let nodeX = fixture.makeNode(value: "X")

        nodeX.leftChild = nodeY
        nodeX.rightChild = nodeD

        nodeY.leftChild = nodeZ
        nodeY.rightChild = nodeC

        nodeZ.leftChild = nodeA
        nodeZ.rightChild = nodeB

        let sut = fixture.makeSUT(root: nodeX)
        let returnedNode = try XCTUnwrap(sut.rotateRight(nodeX))

        let expectedArray = ["Y", "Z", "A", "B", "X", "C", "D"]
        var traversedArray = [String]()

        returnedNode.traversePreOrder {
            traversedArray.append($0)
        }

        XCTAssertEqual(traversedArray, expectedArray)
    }

    /// Validates that `rotateRightLeft(node:)` returns the given `node`
    /// when its `rightChild` is `nil`.
    func test_rotateRightLeft_returns_nil() throws {
        let expectedValue = 987
        let rightNode = fixture.makeNode(value: expectedValue)

        let root = fixture.makeNode(value: 876)
        root.rightChild = rightNode

        let sut = fixture.makeSUT(root: root)

        let returnedNode = try XCTUnwrap(sut.rotateRightLeft(rightNode))
        XCTAssertEqual(returnedNode.value, expectedValue)
    }

    /// Validates that `rotateRightLeft(node:)` works as expected.
    func test_rotateRightLeft_success() throws {
        let node36 = fixture.makeNode(value: 36)
        let node37 = fixture.makeNode(value: 37)
        let node25 = fixture.makeNode(value: 25)

        node25.rightChild = node37
        node37.leftChild = node36

        let sut = fixture.makeSUT(root: node25)
        let returnedNode = try XCTUnwrap(sut.rotateRightLeft(node25))

        let expectedArray = [36, 25, 37]
        var traversedArray = [Int]()

        returnedNode.traversePreOrder {
            traversedArray.append($0)
        }

        XCTAssertEqual(traversedArray, expectedArray)
    }

    /// Validates that `rotateLeftRight(node:)` returns the given `node`
    /// when its `leftChild` is `nil`.
    func test_rotateLeftRight_returns_nil() throws {
        let expectedValue = 567
        let leftNode = fixture.makeNode(value: expectedValue)

        let root = fixture.makeNode(value: 678)
        root.leftChild = leftNode

        let sut = fixture.makeSUT(root: root)

        let returnedNode = try XCTUnwrap(sut.rotateLeftRight(leftNode))
        XCTAssertEqual(returnedNode.value, expectedValue)
    }

    /// Validates that `rotateLeftRight(node:)` works as expected.
    func test_rotateLeftRight_success() throws {
        let node25 = fixture.makeNode(value: 25)
        let node10 = fixture.makeNode(value: 10)
        let node15 = fixture.makeNode(value: 15)

        node25.leftChild = node10
        node10.rightChild = node15

        let sut = fixture.makeSUT(root: node25)
        let returnedNode = try XCTUnwrap(sut.rotateLeftRight(node25))

        let expectedArray = [15, 10, 25]
        var traversedArray = [Int]()

        returnedNode.traversePreOrder {
            traversedArray.append($0)
        }

        XCTAssertEqual(traversedArray, expectedArray)
    }
    
    /// Validates that `insert(from:value:)` works as expected.
    func test_insert_success() throws {
        let numbers = [9, 5, 4, 8, 1, 12, 2, 11, 14, 13, 10, 7, 0, 3, 6]
        var sut = AVLTree<Int>()

        for index in numbers.indices {
            sut.insert(numbers[index])
        }

        let root = try XCTUnwrap(sut.root)

        let expectedArray = [9, 5, 2, 1, 0, 4, 3, 7, 6, 8, 12, 11, 10, 14, 13]
        var traversedArray = [Int]()

        root.traversePreOrder {
            traversedArray.append($0)
        }

        XCTAssertEqual(traversedArray, expectedArray)
    }

    /// Validates that `remove(value:)` keeps `root` to be `nil` when the tree is empty.
    func test_remove_keeps_root_nil() throws {
        var sut = AVLTree<Int>()
        XCTAssertNil(sut.root)

        sut.remove(123)

        XCTAssertNil(sut.root)
    }

    /// Validates that `remove(value:)` works as expected.
    func test_remove_success() throws {
        let numbers = [9, 5, 4, 8, 1, 12, 2, 11, 14, 13, 10, 7, 0, 3, 6]
        let toBeRemoved = numbers.shuffled()

        var sut = AVLTree<Int>()

        for index in numbers.indices {
            sut.insert(numbers[index])
        }
        XCTAssertNotNil(sut.root)

        for value in toBeRemoved {
            sut.remove(value)
        }

        XCTAssertNil(sut.root)
    }
}

struct AVLTreeFixture {
    func makeSUT<T>(value: T) -> AVLTree<T> {
        var tree = AVLTree<T>()
        tree.insert(value)
        return tree
    }

    func makeSUT<T>(root: AVLNode<T>) -> AVLTree<T> {
        AVLTree(root: root)
    }

    func makeNode<T>(value: T, height: Int = 0) -> AVLNode<T> {
        AVLNode(value: value, height: height)
    }
}
