import Foundation

/// A node in the tree using reference semantics.
public final class TreeNode<T> {
    /// The node's attached value.
    public private(set) var value: T
    
    /// Pointer to the left child node.
    public private(set) var left: TreeNode?
    
    /// Pointer to the right child node.
    public private(set) var right: TreeNode?
    
    // MARK: - Initialization
    /// Initializes using the provided `value`, and optional `left` and `right` child nodes.
    /// - Parameters:
    ///   - value: The value to attach to this node.
    ///   - left: Pointer to the left child node. Defaults to `nil`.
    ///   - right: Pointer to the right child node. Defaults to `nil`.
    public init(value: T, left: TreeNode? = nil, right: TreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
    
    // MARK: - API
    /// Sets the node's `value` to the given `value`.
    /// - Parameter value: The new value.
    public func set(value: T) {
        self.value = value
    }
    
    /// Sets the pointer to the `left` child node to the given `left`.
    /// - Parameter left: The new left child pointer.
    public func set(left: TreeNode<T>?) {
        self.left = left
    }
    
    /// Sets the pointer to the `right` child node to the given `right`.
    /// - Parameter right: The new right child pointer.
    public func set(right: TreeNode<T>?) {
        self.right = right
    }
}
