import Foundation

public class TrieNode<Key: Hashable> {
  
  // key holds the data for the node.
  // This is optional because the root node of the trie has no key.
  public var key: Key?
  
  // A TrieNode holds a weak reference to its parent.
  // This reference simplifies the remove method later on.
  public weak var parent: TrieNode?
  
  // In a trie, a node needs to hold multiple different elements.
  // You’ve declared a children dictionary to help with that.
  public var children: [Key: TrieNode] = [:]
  
  // As discussed earlier, isTerminating acts as an indicator for the end of a collection.
  public var isTerminating = false
  
  public init(key: Key?, parent: TrieNode?) {
    self.key = key
    self.parent = parent
  }
}
