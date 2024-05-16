import Foundation

/// A reference semantics implementation of a tree data structure.
public final class Tree<T> {
    /// The root node in the tree. Defaults to `nil`.
    public private(set) var root: TreeNode<T>?
    
    // MARK: - Initialization
    /// Initializes using the given `root` node.
    /// - Parameter root: The tree's root. Defaults to `nil`.
    public init(root: TreeNode<T>? = nil) {
        self.root = root
    }
}
