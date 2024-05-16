import Foundation

/// Represents an AVL tree, a balanced binary search tree.
public struct AVLTree<Element: Comparable> {
    /// The root node of the tree.
    public private(set) var root: AVLNode<Element>?

    // MARK: - API
    /// Inserts the given `value` into the tree starting at the `root`.
    /// The `root` may have a different value (maybe `nil`) after the
    /// insertion has completed.
    /// - Parameter value: The value to be inserted.
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    /// Removes the given `value` from the tree starting from the `root`.
    /// The `root` may have a different value (maybe `nil`) after the
    /// deletion has completed.
    /// - Parameter value: The value to be removed.
    public mutating func remove(_ value: Element) {
        root = remove(from: root, value: value)
    }

    // MARK: - Utilities
    /// Rotates the tree in the left direction at the given `node`.
    /// - Parameter node: The node from which to rotate.
    /// - Returns: The new root of the tree, rotated left from the previous position.
    internal func rotateLeft(_ node: AVLNode<Element>) -> AVLNode<Element>? {
        guard let pivot = node.rightChild else {
            return nil
        }

        node.rightChild = pivot.leftChild
        pivot.leftChild = node
        node.height = Swift.max(node.leftHeight, node.rightHeight) + 1
        pivot.height = Swift.max(pivot.leftHeight, pivot.rightHeight) + 1

        return pivot
    }

    /// Rotates the tree in the right direction at the given `node`.
    /// - Parameter node: The node from which to rotate.
    /// - Returns: The new root of the tree, rotated right from the previous position.
    internal func rotateRight(_ node: AVLNode<Element>) -> AVLNode<Element>? {
        guard let pivot = node.leftChild else {
            return nil
        }

        node.leftChild = pivot.rightChild
        pivot.rightChild = node
        node.height = Swift.max(node.leftHeight, node.rightHeight) + 1
        pivot.height = Swift.max(pivot.leftHeight, pivot.rightHeight) + 1

        return pivot
    }

    /// Performs a right rotation on the right child before doing the left rotation.
    /// - Parameter node: The node from which to rotate.
    /// - Returns: The new root of the tree, rotated right and then left from
    /// the previous position.
    internal func rotateRightLeft(_ node: AVLNode<Element>) -> AVLNode<Element>? {
        guard let rightChild = node.rightChild else {
            return node
        }

        node.rightChild = rotateRight(rightChild)

        return rotateLeft(node)
    }

    /// Performs a left rotation on the left child before doing the right rotation.
    /// - Parameter node: The node from which to rotate.
    /// - Returns: The new root of the tree, rotated left and then right from
    /// the previous position.
    internal func rotateLeftRight(_ node: AVLNode<Element>) -> AVLNode<Element>? {
        guard let leftChild = node.leftChild else {
            return node
        }

        node.leftChild = rotateLeft(leftChild)

        return rotateRight(node)
    }

    /// Uses `balanceFactor` plus the various rotation functions to balance a tree.
    /// - Parameter node: The root node from which the balance should progress.
    /// - Returns: The balanced root node. May be `nil`.
    private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element>? {
        switch node.balanceFactor {
        case 2:
            if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
                return rotateLeftRight(node)
            } else {
                return rotateRight(node)
            }
        case -2:
            if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
                return rotateRightLeft(node)
            } else {
                return rotateLeft(node)
            }
        default:
            return node
        }
    }
    
    /// Inserts the provided `value` starting from the given `node`.
    /// - Parameters:
    ///   - node: The node at which to begin the insertion.
    ///   This is typically the root of the tree.
    ///   - value: The value to be inserted.
    /// - Returns: The tree, balanced from the given node.
    /// Its value may be different from what it originally was.
    /// May be `nil`.
    private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return AVLNode(value: value)
        }

        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }

        guard let balancedNode = balanced(node) else {
            return nil
        }

        balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
    
    /// Removes the given `value` from the tree starting from the given `node`.
    /// - Parameters:
    ///   - node: The node from which to begin the removal.
    ///   This is typically the root of the tree.
    ///   - value: The value to be removed.
    /// - Returns: The tree, balanced from the given node.
    /// Its value may be different from what it originally was.
    /// May be `nil`.
    private func remove(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
        guard let node = node else {
            return nil
        }

        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }

            if let rightNode = node.rightChild {
                node.value = rightNode.min.value
            }
            node.rightChild = remove(from: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(from: node.leftChild, value: value)
        } else {
            node.rightChild = remove(from: node.rightChild, value: value)
        }

        guard let balancedNode = balanced(node) else {
            return nil
        }

        balancedNode.height = Swift.max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
        return balancedNode
    }
}

extension AVLNode {
    fileprivate var min: AVLNode {
        leftChild?.min ?? self
    }
}
