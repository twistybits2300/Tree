import Foundation

/// Represents a node in an AVL tree, one
/// that ensures to keep the tree balanced.
public final class AVLNode<Element: Equatable>: BinaryTreeNode {
    /// The value attached to this node.
    public var value: Element

    /// Points the the child node on the left.
    public var leftChild: AVLNode?

    /// Points the the child node on the right.
    public var rightChild: AVLNode?

    /// The node's height (i.e. the longest distance from a node to a leaf node).
    public internal(set) var height = 0
    
    /// Initializes using the provided `value` and `height`.
    /// - Parameters:
    ///   - value: The node's value.
    ///   - height: The height of the node (distance to a leaf node).
    ///   Defaults to `0`.
    public init(value: Element, height: Int = 0) {
        self.value = value
        self.height = height
    }

    // MARK: - API
    /// Returns the height of the left child node;
    /// `-1` if the left child is `nil`.
    public var leftHeight: Int {
        guard let leftNode = leftChild else {
            return -1
        }

        return leftNode.height
    }

    /// Returns the height of the right child node;
    /// `-1` if the right child is `nil`.
    public var rightHeight: Int {
        guard let rightNode = rightChild else {
            return -1
        }

        return rightNode.height
    }

    /// The difference between the heights of the left and right child nodes.
    public var balanceFactor: Int {
        leftHeight - rightHeight
    }
}
