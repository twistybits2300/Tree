import XCTest
import os
@testable import Tree

/// Validation of `Tree+DFS`.
final class Tree_DFSTests: XCTestCase {
    private let fixture = TreeFixture()

    /// Validates that `inOrderTraversal(visit:)` does not call the visitor closure when the
    /// tree is empty.
    func test_inOrderTraversal_empty() throws {
        var count = 0
        let sut = fixture.makeEmptyTreeSUT()
        
        sut.inOrderTraversal { _ in
            count += 1
        }
        XCTAssertEqual(count, 0)
    }
    
    /// Validates that `inOrderTraversal(visit:)` visits each of the nodes of the tree in the
    /// expected order.
    func test_inOrderTraversal() throws {
        let expectedValues = [4, 2, 5, 1, 6, 3, 7]
        var visitedNodes = [TreeNode<Int>]()
        
        let root = fixture.makeNodeSUT(1)
        root.set(left: fixture.makeNodeSUT(2))
        root.set(right: fixture.makeNodeSUT(3))
        
        root.left?.set(left: fixture.makeNodeSUT(4))
        root.left?.set(right: fixture.makeNodeSUT(5))
        
        root.right?.set(left: fixture.makeNodeSUT(6))
        root.right?.set(right: fixture.makeNodeSUT(7))
        
        let sut = fixture.makeTreeSUT(root: root)
        sut.inOrderTraversal { node in
            visitedNodes.append(node)
        }
        
        let visitedValues = visitedNodes.map { $0.value }
        XCTAssertEqual(visitedValues, expectedValues)
    }
    
    /// Validates that `preOrderTraversal(visit:)` does not call the visitor closure when the
    /// tree is empty.
    func test_preOrderTraversal_empty() throws {
        var count = 0
        let sut = fixture.makeEmptyTreeSUT()
        
        sut.preOrderTraversal { _ in
            count += 1
        }
        XCTAssertEqual(count, 0)
    }
    
    /// Validates that `preOrderTraversal(visit:)` visits each of the nodes of the tree in the
    /// expected order.
    func test_preOrderTraversal() throws {
        let expectedValues = [1, 2, 4, 5, 3, 6, 7]
        var visitedNodes = [TreeNode<Int>]()
        
        let root = fixture.makeNodeSUT(1)
        root.set(left: fixture.makeNodeSUT(2))
        root.set(right: fixture.makeNodeSUT(3))
        
        root.left?.set(left: fixture.makeNodeSUT(4))
        root.left?.set(right: fixture.makeNodeSUT(5))
        
        root.right?.set(left: fixture.makeNodeSUT(6))
        root.right?.set(right: fixture.makeNodeSUT(7))
        
        let sut = fixture.makeTreeSUT(root: root)
        sut.preOrderTraversal { node in
            visitedNodes.append(node)
        }
        
        let visitedValues = visitedNodes.map { $0.value }
        XCTAssertEqual(visitedValues, expectedValues)
    }
    
    /// Validates that `postOrderTraversal(visit:)` does not call the visitor closure when the
    /// tree is empty.
    func test_postOrderTraversal_empty() throws {
        var count = 0
        let sut = fixture.makeEmptyTreeSUT()
        
        sut.postOrderTraversal { _ in
            count += 1
        }
        XCTAssertEqual(count, 0)
    }
    
    /// Validates that `postOrderTraversal(visit:)` visits each of the nodes of the tree in the
    /// expected order.
    func test_postOrderTraversal() throws {
        let expectedValues = [4, 5, 2, 6, 7, 3, 1]
        var visitedNodes = [TreeNode<Int>]()
        
        let root = fixture.makeNodeSUT(1)
        root.set(left: fixture.makeNodeSUT(2))
        root.set(right: fixture.makeNodeSUT(3))
        
        root.left?.set(left: fixture.makeNodeSUT(4))
        root.left?.set(right: fixture.makeNodeSUT(5))
        
        root.right?.set(left: fixture.makeNodeSUT(6))
        root.right?.set(right: fixture.makeNodeSUT(7))
        
        let sut = fixture.makeTreeSUT(root: root)
        sut.postOrderTraversal { node in
            visitedNodes.append(node)
        }
        
        let visitedValues = visitedNodes.map { $0.value }
        XCTAssertEqual(visitedValues, expectedValues)
    }
}
