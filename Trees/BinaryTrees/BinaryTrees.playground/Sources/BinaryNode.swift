import Foundation

public class BinaryNode<Element> {
  
  public var value: Element
  public var leftChild: BinaryNode?
  public var rightChild: BinaryNode?
  
  public init(value: Element) {
    self.value = value
  }
}

// Visualize a binary tree in the console
// This algorithm is based on an implementation by Károly Lőrentey in his book Optimizing Collections,
//  available from https://www.objc.io/books/optimizing-collections/.
extension BinaryNode: CustomStringConvertible {
  public var description: String {
    return diagram(for: self)
  }
  
  private func diagram(for node: BinaryNode?,
                       _ top: String = "",
                       _ root: String = "",
                       _ bottom: String = "") -> String {
    
    guard let node = node else {
      return root + "nil\n"
    }
    
    if node.leftChild == nil && node.rightChild == nil {
      return root + "\(node.value)\n"
    }
    
    return diagram(for: node.rightChild,
                   top + " ", top + "┌──", top + "│ ")
      + root + "\(node.value)\n"
      + diagram(for: node.leftChild,
        bottom + "│ ", bottom + "└──", bottom + " ")
  }
}

extension BinaryNode {
  // In-order traversal
  // 1. Following the rules laid out above, you first traverse to the left-most node before visiting the value.
  // 2. You then traverse to the right-most node.
  public func traverseInOrder(visit: (Element) -> Void) {
    leftChild?.traverseInOrder(visit: visit)
    visit(value)
    rightChild?.traverseInOrder(visit: visit)
  }
  
  // Pre-order traversal
  // Always visits the current node first, then recursively visits the left and right child
  public func traversePreOrder(visit: (Element) -> Void) {
    visit(value)
    leftChild?.traversePreOrder(visit: visit)
    rightChild?.traversePreOrder(visit: visit)
  }

  // Post-order traversal
  // Traversal only visits the current node after the left and right child have been visited recursively.
  public func traversePostOrder(visit: (Element) -> Void) {
    leftChild?.traversePostOrder(visit: visit)
    rightChild?.traversePostOrder(visit: visit)
    visit(value)
  }
}
