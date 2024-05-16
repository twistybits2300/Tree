import XCTest
import os
@testable import Tree

/// Validation of `AVLNode`.
final class AVLNodeTests: XCTestCase {
    private let fixture = AVLNodeFixture()

    /// Validates that `init(value:height:)` correctly captures the provided parameters.
    func test_init_captures_parameters() throws {
        let expectedValue = 111
        let expectedHeight = 2

        let sut = fixture.makeSUT(value: expectedValue, height: expectedHeight)

        XCTAssertEqual(sut.value, expectedValue)
        XCTAssertEqual(sut.height, expectedHeight)
    }

    /// Validates that `leftHeight` returns `-1` if the node's `leftChild` is `nil`.
    func test_leftHeight_returns_minus_one_if_leftChild_is_nil() throws {
        let sut = fixture.makeSUT(value: 123)
        XCTAssertEqual(sut.leftHeight, -1)
    }

    /// Validates that `leftHeight` returns the expected value.
    func test_leftHeight_success() throws {
        let expectedHeight = 5

        let sut = fixture.makeSUT(value: 567)
        sut.leftChild = fixture.makeSUT(value: 456, height: expectedHeight)

        XCTAssertEqual(sut.leftHeight, expectedHeight)
    }

    /// Validates that `rightHeight` returns `-1` if the node's `rightChild` is `nil`.
    func test_rightHeight_returns_minus_one_if_rightChild_is_nil() throws {
        let sut = fixture.makeSUT(value: 123)
        XCTAssertEqual(sut.rightHeight, -1)
    }

    /// Validates that `rightHeight` returns the expected value.
    func test_rightHeight_success() throws {
        let expectedHeight = 5

        let sut = fixture.makeSUT(value: 567)
        sut.rightChild = fixture.makeSUT(value: 456, height: expectedHeight)

        XCTAssertEqual(sut.rightHeight, expectedHeight)
    }

    /// Validates that `balanceFactor` returns the expected value.
    func test_balanceFactor_success() throws {
        let expectedLeftHeight = 4
        let expectedRightHeight = 2
        let expectedBalanceFactor = expectedLeftHeight - expectedRightHeight

        let sut = fixture.makeSUT(value: 123)
        sut.leftChild = fixture.makeSUT(value: 234, height: expectedLeftHeight)
        sut.rightChild = fixture.makeSUT(value: 345, height: expectedRightHeight)

        XCTAssertEqual(sut.balanceFactor, expectedBalanceFactor)
    }

}

struct AVLNodeFixture {
    func makeSUT<T>(value: T, height: Int = 0) -> AVLNode<T> {
        AVLNode(value: value, height: height)
    }
}
