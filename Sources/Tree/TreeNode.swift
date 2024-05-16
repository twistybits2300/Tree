import Foundation

/// A node in the tree using reference semantics.
public final class TreeNode<T>: BinaryTreeNode {
    /// The node's attached value.
    public var value: T
    
    /// Pointer to the left child node.
    public var leftChild: TreeNode?
    
    /// Pointer to the right child node.
    public var rightChild: TreeNode?
    
    // MARK: - Initialization
    /// Initializes using the provided `value`, and optional `left` and `right` child nodes.
    /// - Parameters:
    ///   - value: The value to attach to this node.
    ///   - left: Pointer to the left child node. Defaults to `nil`.
    ///   - right: Pointer to the right child node. Defaults to `nil`.
    public init(value: T, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.leftChild = left
        self.rightChild = right
    }
}
