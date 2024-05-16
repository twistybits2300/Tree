import Foundation

/// A value semantics implementation of a binary search tree data structure.
public struct BinarySearchTree<T: Comparable> {
    /// The root node in the tree. Defaults to `nil`.
    public private(set) var root: TreeNode<T>?
    
    // MARK: - Initialization
    /// Initializes using the given `root` node.
    /// - Parameter root: The tree's root. Defaults to `nil`.
    public init(root: TreeNode<T>? = nil) {
        self.root = root
    }
    
    // MARK: - API
    /// Inserts the given `value` into the tree.
    /// - Parameter value: The value to be inserted.
    public mutating func insert(_ value: T) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: TreeNode<T>?, value: T) -> TreeNode<T> {
        guard let node = node else {
            return TreeNode(value: value)
        }

        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }

        return node
    }
    
    /// Searches the tree starting at the root for the provided `value`.
    /// - Parameter value: The value to be searched for.
    /// - Returns: `true` if the tree contains the `value`; `false` otherwise.
    public func contains(_ value: T) -> Bool {
        var currentNode = root

        while let node = currentNode {
            if node.value == value {
                return true
            }

            if value < node.value {
                currentNode = node.leftChild
            } else {
                currentNode = node.rightChild
            }
        }

        return false
    }
    
    /// Removes the provided `value` from the tree.
    /// - Parameter value: The value to be removed.
    public mutating func remove(_ value: T) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: TreeNode<T>?, value: T) -> TreeNode<T>? {
        guard let node = node else {
            return nil
        }

        if node.value == value {
            if node.leftChild == nil, node.rightChild == nil {
                return nil
            }

            if node.leftChild == nil {
                return node.rightChild
            }

            if node.rightChild == nil {
                return node.leftChild
            }

            if let rightMinValue = node.rightChild?.min.value {
                node.value = rightMinValue
            }
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
}

private extension TreeNode {
    var min: TreeNode {
        leftChild?.min ?? self
    }
}
