import XCTest
import os
@testable import Tree

/// Validation of `Tree+BFS`.
final class Tree_BFSTests: XCTestCase {
    private let fixture = TreeFixture()

    /// Validates that `bfsTraversal(visit:)` does not call the visitor closure when the
    /// tree is empty.
    func test_bfsTraversal_empty() throws {
        var count = 0
        let sut = fixture.makeEmptyTreeSUT()
        
        sut.bfsTraversal { _ in
            count += 1
        }
        XCTAssertEqual(count, 0)
    }
    
    /// Validates that `bfsTraversal(visit:)` visits each of the nodes of the tree in the
    /// expected order.
    func test_bfsTraversal() throws {
        let expectedValues = fixture.numbers
        var visitedNodes = [TreeNode<Int>]()
        
        let root = fixture.makeNodeSUT(1)
        root.leftChild = fixture.makeNodeSUT(2)
        root.rightChild = fixture.makeNodeSUT(3)
        
        root.leftChild?.leftChild = fixture.makeNodeSUT(4)
        root.leftChild?.rightChild = fixture.makeNodeSUT(5)
        
        root.rightChild?.leftChild = fixture.makeNodeSUT(6)
        root.rightChild?.rightChild = fixture.makeNodeSUT(7)
        
        let sut = fixture.makeTreeSUT(root: root)
        sut.bfsTraversal { node in
            visitedNodes.append(node)
        }
        
        let visitedValues = visitedNodes.map { $0.value }
        XCTAssertEqual(visitedValues, expectedValues)
    }
}
