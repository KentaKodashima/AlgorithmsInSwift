import Foundation

/*
 Node:
  Each node is responsible for a value and holds references to all its children using an array.
 */
public class TreeNode<T> {
  public var value: T
  public var children: [TreeNode] = []
  
  public init(_ value: T) {
    self.value = value
  }
  
  // Append a child node to a node
  public func add(_ child: TreeNode) {
    children.append(child)
  }
}

// Depth First
extension TreeNode {
  // This simple code uses recursion process the next node.
  public func forEachDepthFirst(visit: (TreeNode) -> Void) {
    visit(self)
    children.forEach {
      $0.forEachDepthFirst(visit: visit)
    }
  }
}

// Level Order
extension TreeNode {
  // forEachLevelOrder visits each of the nodes in level-order
  public func forEachLevelOrder(visit: (TreeNode) -> Void) {
    visit(self)
    var queue = Queue<TreeNode>()
    children.forEach { queue.enqueue($0) }
    while let node = queue.dequeue() {
      visit(node)
      node.children.forEach { queue.enqueue($0) }
    }
  }
}

// Search Algorithm
extension TreeNode where T: Equatable {
  public func search(_ value: T) -> TreeNode? {
    var result: TreeNode?
    forEachLevelOrder { node in
      if node.value == value {
        result = node
      }
    }
    return result
  }
}
