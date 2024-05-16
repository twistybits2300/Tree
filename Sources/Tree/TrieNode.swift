import Foundation

/// Represents an individual node in a trie.
public class TrieNode<Key: Hashable> {
    /// Holds the data for the node. It is optional 
    /// because the root of the trie has no key.
    public private(set) var key: Key?
    
    /// A weak reference to this node's parent.
    public weak var parent: TrieNode?

    /// This node's child nodes.
    public internal(set) var children: [Key: TrieNode] = [:]

    /// `true` indicates the end of a collection.
    public internal(set) var isTerminating = false

    // MARK: - Initialization
    public init(key: Key? = nil, parent: TrieNode? = nil) {
        self.key = key
        self.parent = parent
    }

    // MARK: - API
    /// Sets the value of `isTerminating` to the provided value.
    /// - Parameter isTerminating: `true` indicates this is the end of the collection.
    public func set(isTerminating: Bool) {
        self.isTerminating = isTerminating
    }
    
    /// Sets the value of `children` at `key` to the given `node`.
    /// - Parameters:
    ///   - key: The key to be set.
    ///   - node: The value to be set.
    public func setChild(key: Key, node: TrieNode?) {
        children[key] = node
    }
}
