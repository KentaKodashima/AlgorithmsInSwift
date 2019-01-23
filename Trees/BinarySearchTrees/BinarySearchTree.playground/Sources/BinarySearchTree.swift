import Foundation

public struct BinarySearchTree<Element: Comparable> {
  public private(set) var root: BinaryNode<Element>?
  
  public init() {}
}

extension BinarySearchTree: CustomStringConvertible {
  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}

// Inserting elements
extension BinarySearchTree {
  // This function will be exposed
  public mutating func insert(_ value: Element) {
    root = insert(from: root, value: value)
  }
  
  private func insert(from node: BinaryNode<Element>?, value: Element)
    -> BinaryNode<Element> {
      // This is a recursive method, so it requires a base case for terminating recursion.
      // If the current node is nil,
      //  you’ve found the insertion point and you return the new BinaryNode.
      guard let node = node else {
        return BinaryNode(value: value)
      }
      // This if statement controls which way the next insert call should traverse.
      // If the new value is less than the current value, you call insert on the left child.
      // If the new value is greater than or equal to the current value,
      //  you’ll call insert on the right child.
      if value < node.value {
        node.leftChild = insert(from: node.leftChild, value: value)
      } else {
        node.rightChild = insert(from: node.rightChild, value: value)
      }
      // Return the current node.
      // This makes assignments of the form node = insert(from: node, value: value)
      //  possible as insert will either create node (if it was nil)
      //   or return node (it it was not nil).
      return node
  }
}

// Finding elements
extension BinarySearchTree {
  // This contains() has O(n) complexity which means it search through all elements in the array
//  public func contains(_ value: Element) -> Bool {
//    guard let root = root else {
//      return false
//    }
//    var found = false
//    root.traverseInOrder {
//      if $0 == value {
//        found = true
//      }
//    }
//    return found
//  }
  
  // This implementation of contains is an O(log n) operation in blanced binary search tree.
  public func contains(_ value: Element) -> Bool {
    // Set current to the root node
    var current = root
    // While current is not nil, check the current node’s value
    while let node = current {
      // If the value is equal to what you’re trying to find, return true
      if node.value == value {
        return true
      }
      // Otherwise, decide whether you’re going to check the left or the right child
      if value < node.value {
        current = node.leftChild
      } else {
        current = node.rightChild
      }
    }
    return false
  }
}

/*
 Removing elements
 
 Case 1: Leaf node
  Removing a leaf node is straightforward; simply detach the leaf node.
 
 Case 2: Nodes with one child
  When removing nodes with one child, you’ll need to reconnect that one child with the rest of the tree:
 
 Case 3: Nodes with two children
  When removing a node with two children, replace the node you removed with smallest node in its right subtree.
  Based on the rules of the BST, this is the leftmost node of the right subtree:
  The new node was the smallest node in the right subtree,
    all nodes in the right subtree will still be greater than or equal to the new node.
  After performing the swap, you can simply remove the value you copied, which is just a leaf node.
 */

private extension BinaryNode {
  
  var min: BinaryNode {
    return leftChild?.min ?? self
  }
}

extension BinarySearchTree {
  
  public mutating func remove(_ value: Element) {
    root = remove(node: root, value: value)
  }
  
  private func remove(node: BinaryNode<Element>?, value: Element)
    -> BinaryNode<Element>? {
      guard let node = node else {
        return nil
      }
      if value == node.value {
        // In the case in which the node is a leaf node,
        //  you simply return nil, thereby removing the current node.
        if node.leftChild == nil && node.rightChild == nil {
          return nil
        }
        // If the node has no left child,
        //  you return node.rightChild to reconnect the right subtree.
        if node.leftChild == nil {
          return node.rightChild
        }
        // If the node has no right child,
        //  you return node.leftChild to reconnect the left subtree.
        if node.rightChild == nil {
          return node.leftChild
        }
        // This is the case in which the node to be removed has both a left and right child.
        // You replace the node’s value with the smallest value from the right subtree.
        // You then call remove on the right child to remove this swapped value.
        node.value = node.rightChild!.min.value
        node.rightChild = remove(node: node.rightChild, value: node.value)
      } else if value < node.value {
        node.leftChild = remove(node: node.leftChild, value: value)
      } else {
        node.rightChild = remove(node: node.rightChild, value: value)
      }
      return node
  }
}
