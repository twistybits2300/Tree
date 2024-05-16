import XCTest
import os
@testable import Tree

/// Validation of `TreeNode`.
final class TreeNodeTests: XCTestCase {
    private let fixture = TreeFixture()
    
    /// Validates that `init(value:)` defaults to setting `left` and `right` child nodes to nil.
    func test_initValue() throws {
        let expectedNumber = fixture.randomNumber
        let sut = fixture.makeNodeSUT(expectedNumber)
        XCTAssertEqual(sut.value, expectedNumber)
        XCTAssertNil(sut.leftChild)
        XCTAssertNil(sut.rightChild)
    }
    
    /// Validates that `init(value:left:right)` correctly captures all given parameters.
    func test_init() throws {
        let leftValue = fixture.randomNumber
        let leftNode = fixture.makeNodeSUT(leftValue)
        
        let rightValue = fixture.randomNumber
        let rightNode = fixture.makeNodeSUT(rightValue)
        
        let nodeValue = fixture.randomNumber
        let sut = TreeNode(value: nodeValue, left: leftNode, right: rightNode)
        XCTAssertEqual(sut.value, nodeValue)
        XCTAssertEqual(sut.leftChild?.value, leftValue)
        XCTAssertEqual(sut.rightChild?.value, rightValue)
    }
}
