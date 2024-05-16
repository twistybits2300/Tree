import Foundation

public protocol BinaryTreeNode {
    associatedtype Element

    /// The value attached to this node.
    var value: Element { get set }

    /// Points the the child node on the left.
    var leftChild: Self? { get set }

    /// Points the the child node on the right.
    var rightChild: Self? { get set }

    /// Performs a recursive in-order traversal of the tree.
    /// - Parameter visit: Called when visiting a node.
    func traverseInOrder(visit: (Element) -> Void)

    /// Performs a recursive pre-order traversal of the tree.
    /// - Parameter visit: Called when visiting a node.
    func traversePreOrder(visit: (Element) -> Void)

    /// Performs a recursive post-order traversal of the tree.
    /// - Parameter visit: Called when visiting a node.
    func traversePostOrder(visit: (Element) -> Void)
}

extension BinaryTreeNode {
    /// Performs a recursive in-order traversal of the tree.
    /// - Parameter visit: Called when visiting a node.
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }

    /// Performs a recursive pre-order traversal of the tree.
    /// - Parameter visit: Called when visiting a node.
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }

    /// Performs a recursive post-order traversal of the tree.
    /// - Parameter visit: Called when visiting a node.
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}
