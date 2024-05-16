import Foundation

/// Represents a trie data structure. Useful for storing 
/// data that can be represented as a collection.
public class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable {

    public typealias Node = TrieNode<CollectionType.Element>
    
    /// The root of the trie.
    internal let root = Node(key: nil, parent: nil)
    
    /// Contains all of the collections in this trie.
    public private(set) var allCollections = Set<CollectionType>()

    // MARK: - Initialization
    /// Initializes an empty trie.
    public init() {
        /* no-op */
    }

    // MARK: - API
    /// Returns the number of collections contained in this trie.
    public var count: Int {
        allCollections.count
    }
    
    /// Returns `true` if there are no collections contained in this trie; `false` otherwise.
    public var isEmpty: Bool {
        allCollections.isEmpty
    }

    /// For determining if every element of the provided `collection` is in this trie.
    /// - Parameter collection: The collection whose elements will be searched for.
    /// - Returns: `true` if all elements in `collection` are found within this trie;
    /// `false` otherwise.
    public func contains(_ collection: CollectionType) -> Bool {
        var currentNode = root

        for key in collection {
            guard let childNode = currentNode.children[key] else {
                return false
            }

            currentNode = childNode
        }

        return currentNode.isTerminating
    }

    /// Inserts the elements in the given `collection` into this trie.
    /// - Parameter collection: The collection of elements to be inserted.
    public func insert(_ collection: CollectionType) {
        var currentNode = root

        for key in collection {
            if currentNode.children[key] == nil {
                currentNode.setChild(key: key, node: Node(key: key, parent: currentNode))
            }

            if let childNode = currentNode.children[key] {
                currentNode = childNode
            }
        }

        if currentNode.isTerminating {
            return
        } else {
            currentNode.set(isTerminating: true)
            allCollections.insert(collection)
        }
    }

    /// Removes the provided `collection` from this trie.
    /// - Parameter collection: The collection to be removed.
    public func remove(_ collection: CollectionType) {
        var currentNode = root

        for key in collection {
            guard let childNode = currentNode.children[key] else {
                return
            }

            currentNode = childNode
        }

        guard currentNode.isTerminating else {
            return
        }

        currentNode.set(isTerminating: false)
        allCollections.remove(collection)

        while let currentNodeKey = currentNode.key,
              let parentNode = currentNode.parent,
              currentNode.children.isEmpty && !currentNode.isTerminating {

            parentNode.setChild(key: currentNodeKey, node: nil)
            currentNode = parentNode
        }
    }
}

extension Trie where CollectionType : RangeReplaceableCollection {
    /// Uses a pattern-matching algorithm to determine the collection
    /// of elements in this trie that match the given `prefix`.
    /// - Parameter prefix: The prefix to be searched for.
    /// - Returns: The collection of elements matching `prefix`; may be empty.
    public func collections(startingWith prefix: CollectionType) -> [CollectionType] {
        var currentNode = root

        for key in prefix {
            guard let childNode = currentNode.children[key] else {
                return []
            }

            currentNode = childNode
        }

        return collections(startingWith: prefix, after: currentNode)
    }

    private func collections(startingWith prefix: CollectionType,
                             after node: Node) -> [CollectionType] {
        var results = [CollectionType]()
        
        if node.isTerminating {
            results.append(prefix)
        }

        for childNode in node.children.values {
            var prefix = prefix

            if let key = childNode.key {
                prefix.append(key)
                results.append(contentsOf: collections(startingWith: prefix, after: childNode))
            }
        }

        return results
    }
}
