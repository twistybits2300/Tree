import XCTest
@testable import Tree

/// Validation of `Tree`.
final class TreeTests: XCTestCase {
    private let fixture = TreeFixture()
    
    /// Validates that `init()` sets the `root` node to `nil`.
    func test_init() throws {
        let sut = fixture.makeEmptyTreeSUT()
        XCTAssertNil(sut.root)
    }
    
    /// Validates that `init(root:)` correctly captures the given `root` node.
    func test_initRoot() throws {
        let rootValue = fixture.randomNumber
        let sut = fixture.makeTreeSUT(value: rootValue)
        XCTAssertEqual(sut.root?.value, rootValue)
    }
}

struct TreeFixture {
    var randomNumber: Int {
        Int.random(in: 0..<100)
    }
    var numbers: [Int] {
        Array(0..<10)
    }
    
    var shuffledNumbers: [Int] {
        numbers.shuffled()
    }
    
    func makeNodeSUT(_ value: Int) -> TreeNode<Int> {
        TreeNode(value: value)
    }
    
    func makeEmptyTreeSUT() -> Tree<Int> {
        Tree()
    }
    
    func makeTreeSUT(value: Int) -> Tree<Int> {
        Tree(root: makeNodeSUT(value))
    }
}
