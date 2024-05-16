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
        XCTAssertNil(sut.left)
        XCTAssertNil(sut.right)
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
        XCTAssertEqual(sut.left?.value, leftValue)
        XCTAssertEqual(sut.right?.value, rightValue)
    }
    
    /// Validates that `set(value:)` correctly sets the `value`.
    func test_setValue() throws {
        let originalNumber = fixture.randomNumber
        let sut = fixture.makeNodeSUT(originalNumber)
        XCTAssertEqual(sut.value, originalNumber)
        
        let expectedNumber = fixture.randomNumber
        sut.set(value: expectedNumber)
        XCTAssertEqual(sut.value, expectedNumber)
    }
    
    /// Validates that `set(left:)` correctly sets the pointer to the `left` child node.
    func test_setLeft() throws {
        let nodeValue = fixture.randomNumber
        
        let originalLeftValue = fixture.randomNumber
        let leftNode = fixture.makeNodeSUT(originalLeftValue)
        
        let originalRightValue = fixture.randomNumber
        let rightNode = fixture.makeNodeSUT(originalRightValue)
        
        let sut = TreeNode(value: nodeValue, left: leftNode, right: rightNode)
        XCTAssertEqual(sut.value, nodeValue)
        XCTAssertEqual(sut.left?.value, originalLeftValue)
        XCTAssertEqual(sut.right?.value, originalRightValue)
        
        let leftValue = fixture.randomNumber
        leftNode.set(value: leftValue)
        XCTAssertEqual(leftNode.value, leftValue)
        XCTAssertEqual(sut.left?.value, leftValue)
        
        let rightValue = fixture.randomNumber
        rightNode.set(value: rightValue)
        XCTAssertEqual(rightNode.value, rightValue)
        XCTAssertEqual(sut.right?.value, rightValue)
    }
}
