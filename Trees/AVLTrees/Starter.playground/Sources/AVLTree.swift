// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

public struct AVLTree<Element: Comparable> {
  
  public private(set) var root: AVLNode<Element>?
  
  public init() {}
}

extension AVLTree: CustomStringConvertible {
  
  public var description: String {
    guard let root = root else { return "empty tree" }
    return String(describing: root)
  }
}

extension AVLTree {
  
  public mutating func insert(_ value: Element) {
    root = insert(from: root, value: value)
  }
  
  // Instead of returning the node directly after inserting, you pass it into balanced.
  // This ensures every node in the call stack is checked for balancing issues.
  // You also update the node’s height.
  private func insert(from node: AVLNode<Element>?, value: Element) -> AVLNode<Element> {
    guard let node = node else {
      return AVLNode(value: value)
    }
    if value < node.value {
      node.leftChild = insert(from: node.leftChild, value: value)
    } else {
      node.rightChild = insert(from: node.rightChild, value: value)
    }
    let balancedNode = balanced(node)
    balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
    return balancedNode
  }
  
  private func leftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    // The right child is chosen as the pivot.
    // This node will replace the rotated node as the root of the subtree (it will move up a level).
    let pivot = node.rightChild!
    
    // The node to be rotated will become the left child of the pivot (it moves down a level).
    // This means that the current left child of the pivot must be moved elsewhere.
    node.rightChild = pivot.leftChild
    
    // The pivot’s leftChild can now be set to the rotated node.
    pivot.leftChild = node
    
    // Update the heights of the rotated node and the pivot.
    node.height = max(node.leftHeight, node.rightHeight) + 1
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
    
    // Finally, return the pivot so that it can replace the rotated node in the tree.
    return pivot
  }
  
  private func rightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    let pivot = node.leftChild!
    node.leftChild = pivot.rightChild
    pivot.rightChild = node
    node.height = max(node.leftHeight, node.rightHeight) + 1
    pivot.height = max(pivot.leftHeight, pivot.rightHeight) + 1
    return pivot
  }
  
  private func rightLeftRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    guard let rightChild = node.rightChild else {
      return node
    }
    node.rightChild = rightRotate(rightChild)
    return leftRotate(node)
  }
  
  private func leftRightRotate(_ node: AVLNode<Element>) -> AVLNode<Element> {
    guard let leftChild = node.leftChild else {
      return node
    }
    node.leftChild = leftRotate(leftChild)
    return rightRotate(node)
  }
  
  // A method that uses balanceFactor to decide whether a node requires balancing or not
  private func balanced(_ node: AVLNode<Element>) -> AVLNode<Element> {
    switch node.balanceFactor {
    // A balanceFactor of 2 suggests that the left child is “heavier”
    //  (that is, contains more nodes) than the right child.
    // This means that you want to use either right or left-right rotations.
    case 2:
      if let leftChild = node.leftChild, leftChild.balanceFactor == -1 {
        return leftRightRotate(node)
      } else {
        return rightRotate(node)
      }
    // A balanceFactor of -2 suggests that the right child is heavier than the left child.
    // This means that you want to use either left or right-left rotations.
    case -2:
      if let rightChild = node.rightChild, rightChild.balanceFactor == 1 {
        return rightLeftRotate(node)
      } else {
        return leftRotate(node)
      }
    // The default case suggests that the particular node is balanced.
    // There’s nothing to do here except to return the node.
    default:
      return node
    }
  }
}

extension AVLTree {
  
  public func contains(_ value: Element) -> Bool {
    var current = root
    while let node = current {
      if node.value == value {
        return true
      }
      if value < node.value {
        current = node.leftChild
      } else {
        current = node.rightChild
      }
    }
    return false
  }
}

private extension AVLNode {
  
  var min: AVLNode {
    return leftChild?.min ?? self
  }
}

extension AVLTree {
  
  public mutating func remove(_ value: Element) {
    root = remove(node: root, value: value)
  }
  
  private func remove(node: AVLNode<Element>?, value: Element) -> AVLNode<Element>? {
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
      node.value = node.rightChild!.min.value
      node.rightChild = remove(node: node.rightChild, value: node.value)
    } else if value < node.value {
      node.leftChild = remove(node: node.leftChild, value: value)
    } else {
      node.rightChild = remove(node: node.rightChild, value: value)
    }
    
    let balancedNode = balanced(node)
    balancedNode.height = max(balancedNode.leftHeight, balancedNode.rightHeight) + 1
    return balancedNode
  }
}
