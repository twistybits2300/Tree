import XCTest
@testable import Tree

final class TreeTests: XCTestCase {
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
}
