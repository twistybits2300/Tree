import Foundation

// MARK: - Depth-first traversal (BFS)
extension Tree {
    /// Performs an in-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func inOrderTraversal(visit visitor: (TreeNode<T>) -> Void) {
        inOrderTraversal(root: root, visit: visitor)
    }

    private func inOrderTraversal(root: TreeNode<T>?, visit visitor: (TreeNode<T>) -> Void) {
        guard let node = root else {
            return
        }
        
        inOrderTraversal(root: node.left, visit: visitor)
        visitor(node)
        inOrderTraversal(root: node.right, visit: visitor)
    }
    
    /// Performs a pre-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func preOrderTraversal(visit visitor: (TreeNode<T>) -> Void) {
        preOrderTraversal(root: root, visit: visitor)
    }

    private func preOrderTraversal(root: TreeNode<T>?, visit visitor: (TreeNode<T>) -> Void) {
        guard let node = root else {
            return
        }
        
        visitor(node)
        preOrderTraversal(root: node.left, visit: visitor)
        preOrderTraversal(root: node.right, visit: visitor)
    }
    
    /// Performs a post-order traversal of the tree starting at the given `root`,
    /// calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func postOrderTraversal(visit visitor: (TreeNode<T>) -> Void) {
        postOrderTraversal(root: root, visit: visitor)
    }

    private func postOrderTraversal(root: TreeNode<T>?, visit visitor: (TreeNode<T>) -> Void) {
        guard let node = root else {
            return
        }
        
        postOrderTraversal(root: node.left, visit: visitor)
        postOrderTraversal(root: node.right, visit: visitor)
        visitor(node)
    }
}
