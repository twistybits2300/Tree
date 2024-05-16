# Tree

An implementation of the tree data structure.

Contains:
- `AVLTree`: an AVL tree, a balanced binary search tree using value semantics.
    - `AVLNode`: Represents a node in an AVL tree, one that ensures to keep the tree balanced. Uses reference semantics.
- `BinarySearchTree`: A value semantics implementation of a binary search tree data structure using value semantics.
    - `TreeNode`: A node in the tree using reference semantics.
- `BinaryTreeNode`: A protocol that provides default DFS traversal.
- `Tree`: A reference semantics implementation of a tree data structure.
    - `TreeNode: BinaryTreeNode`: A node in the tree using reference semantics.
        - breadth-first traversal
        - depth-first traversals (via `BinaryTreeNode`)
- `Trie`: Represents a trie data structure. Useful for storing data that can be represented as a collection. Uses reference semantics.
    - `TrieNode`: Represents an individual node in a trie; uses reference semantics.
