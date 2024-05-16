import Foundation

// MARK: - Breadth-first traversal (BFS)
extension Tree {
    /// Performs an in-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func inOrderTraversal(visit visitor: (TreeNode<T>) -> Void) {
        inOrderTraversal(root: root, visit: visitor)
    }
    
    /// Performs an in-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameters:
    ///   - root: The root to start the traversal from.
    ///   - visitor: The closure to call on visiting each node in the traversal.
    private func inOrderTraversal(root: TreeNode<T>?, visit visitor: (TreeNode<T>) -> Void) {
        guard let node = root else {
            return
        }
        
        inOrderTraversal(root: node.left, visit: visitor)
        visitor(node)
        inOrderTraversal(root: node.right, visit: visitor)
    }
}
