import Foundation

// MARK: - Depth-first traversal (BFS)
extension Tree {
    /// Performs an in-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    //public func inOrderTraversal(visit visitor: (TreeNode<T>) -> Void) {
    public func inOrderTraversal(visit visitor: (T) -> Void) {
        root?.traverseInOrder(visit: visitor)
    }
    
    /// Performs a pre-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func preOrderTraversal(visit visitor: (T) -> Void) {
        root?.traversePreOrder(visit: visitor)
    }
    
    /// Performs a post-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func postOrderTraversal(visit visitor: (T) -> Void) {
        root?.traversePostOrder(visit: visitor)
    }
}
