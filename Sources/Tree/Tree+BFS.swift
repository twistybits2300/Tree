import Foundation
import Queue

// MARK: - Breadth-first traversal (BFS)
extension Tree {
    /// Performs a breadth-first (level-order) traversal of the tree starting at the
    /// given `root`, calling the given `visitor` closure on each traversed node.
    /// - Parameter visitor: The closure to call on visiting each node in the traversal.
    public func bfsTraversal(visit visitor: (TreeNode<T>) -> Void) {
        bfsTraversal(root: root, visit: visitor)
    }
    
    private func bfsTraversal(root: TreeNode<T>?, visit visitor: (TreeNode<T>) -> Void) {
        guard let rootNode = root else {
            return
        }
        
        var queue = QueueArray<TreeNode<T>>()
        queue.enqueue(rootNode)
        
        while !queue.isEmpty {
            if let currentNode = queue.dequeue() {
                visitor(currentNode)
                
                if let leftNode = currentNode.left {
                    queue.enqueue(leftNode)
                }
                
                if let rightNode = currentNode.right {
                    queue.enqueue(rightNode)
                }
            }
        }
    }
}
