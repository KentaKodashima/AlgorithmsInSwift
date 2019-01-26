import Foundation

// The Trie class is built for all types that adopt the Collection protocol, including String.
// Each element inside the collection must be Hashable.
// This is required because you’ll use the collection’s elements as keys for the children dictionary in TrieNode.
public class Trie<CollectionType: Collection & Hashable> where CollectionType.Element: Hashable  {
  
  public typealias Node = TrieNode<CollectionType.Element>
  
  private let root = Node(key: nil, parent: nil)
  
  public private(set) var collections: Set<CollectionType> = []
  
  public var count: Int {
    return collections.count
  }
  
  public var isEmpty: Bool {
    return collections.isEmpty
  }
  
  public init() {}
  
  // The time complexity for this algorithm is O(k),
  //  where k is the number of elements in the collection you’re trying to insert.
  // This is because you need to traverse through or
  //  create each node that represents each element of the new collection.
  public func insert(_ collection: CollectionType) {
    // current keeps track of your traversal progress, which starts with the root node.
    var current = root
    
    // A trie stores each element of a collection in separate nodes.
    // For each element of the collection,
    //  you first check if the node currently exists in the children dictionary.
    // If it doesn’t, you create a new node. During each loop, you move current to the next node.
    for element in collection {
      if current.children[element] == nil {
        current.children[element] = Node(key: element, parent: current)
      }
      current = current.children[element]!
    }
    
    // After iterating through the for loop, current
    //  should be referencing the node representing the end of the collection.
    // You mark that node as the terminating node.
    if current.isTerminating {
      return
    } else {
      current.isTerminating = true
      collections.insert(collection)
    }
  }
  
  // The time complexity of contains is O(k),
  //  where k is the number of elements in the collection that you’re looking for.
  // This is because you need to traverse through k nodes to
  //  find out whether or not the collection is in the trie.
  public func contains(_ collection: CollectionType) -> Bool {
    var current = root
    for element in collection {
      guard let child = current.children[element] else {
        return false
      }
      current = child
    }
    // When you reach the last element of the collection, it must be a terminating element.
    // If not, the collection was not added to the tree and
    //  what you’ve found is merely a subset of a larger collection.
    return current.isTerminating
  }
  
  // The time complexity of this algorithm is O(k),
  //  where k represents the number of elements of the collection that you’re trying to remove.
  public func remove(_ collection: CollectionType) {
    // You use it here to check if the collection is part of
    //  the trie and to point current to the last node of the collection.
    var current = root
    for element in collection {
      guard let child = current.children[element] else {
        return
      }
      current = child
    }
    guard current.isTerminating else {
      return
    }
    // You set isTerminating to false so the current node can be removed by the loop in the next step.
    collections.remove(collection)
    // Since nodes can be shared, you don’t want to carelessly remove elements that belong to another collection.
    // If there are no other children in the current node,
    //  it means that other collections do not depend on the current node.
    // You also check to see if the current node is a terminating node.
    // If it is, then it belongs to another collection.
    // As long as current satisfies these conditions,
    //  you continually backtrack through the parent property and remove the nodes.
    while let parent = current.parent,
      current.children.isEmpty && !current.isTerminating {
        parent.children[current.key!] = nil
        current = parent
    }
  }
}

public extension Trie where CollectionType: RangeReplaceableCollection {
  // collection(startingWith:) has a time complexity of O(k*m),
  //  where k represents the longest collection matching
  //  the prefix and m represents the number of collections that match the prefix.
  func collections(startingWith prefix: CollectionType) -> [CollectionType] {
    // Verifying that the trie contains the prefix. If not, return an empty array.
    var current = root
    for element in prefix {
      guard let child = current.children[element] else {
        return []
      }
      current = child
    }
    
    // After you’ve found the node that marks the end of the prefix,
    //  you call a recursive helper method collections(startingWith:after:)
    //  to find all the sequences after the current node.
    return collections(startingWith: prefix, after: current)
  }
  
  private func collections(startingWith prefix: CollectionType,
                              after node: Node) -> [CollectionType] {
    // Create an array to hold the results.
    // If the current node is a terminating node, you add it to the results.
    var results: [CollectionType] = []
    
    if node.isTerminating {
      results.append(prefix)
    }
    
    // Next, you need to check the current node’s children.
    // For every child node, you recursively call
    //  collections(startingWith:after:) to seek out other terminating nodes.
    for child in node.children.values {
      var prefix = prefix
      prefix.append(child.key!)
      results.append(contentsOf: collections(startingWith: prefix, after: child))
    }
    
    return results
  }
}
