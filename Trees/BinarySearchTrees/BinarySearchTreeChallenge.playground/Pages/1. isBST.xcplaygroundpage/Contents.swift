// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*:
 # Binary Search Tree Challenges
 ### Challenge 1
 Create a function that checks if a binary tree is a binary search tree.
 */

var bst = BinarySearchTree<Int>()
bst.insert(3)
bst.insert(1)
bst.insert(4)
bst.insert(0)
bst.insert(2)
bst.insert(5)

print(bst)

// Your solution here
extension BinaryNode where Element: Comparable {
  
  var isBinarySearchTree: Bool {
    return isBST(self, min: nil, max: nil)
  }
  
  // isBST is responsible for recursively traversing through the tree
  //  and checking for the BST property.
  // It needs to keep track of progress via a reference to a BinaryNode,
  //  and also keep track of the min and max values to verify the BST property
  private func isBST(_ tree: BinaryNode<Element>?,
                     min: Element?,
                     max: Element?) -> Bool {
    // If tree is nil, then there are no nodes to inspect.
    // A nil node is a binary search tree, so you'll return true in that case.
    guard let tree = tree else {
      return true
    }
    
    // This is essentially a bounds check.
    // If the current value exceeds the bounds of the min and max values,
    //  the current node does not respect the binary search tree rules.
    if let min = min, tree.value <= min {
      return false
    } else if let max = max, tree.value > max {
      return false
    }
    
    // When traversing through the left children, the current value is passed in as the max value.
    // This is because any nodes in the left side cannot be greater than the parent.
    // Vice versa, when traversing to the right, the min value is updated to the current value.
    // Any nodes in the right side must be greater than the parent.
    // If any of the recursive calls evaluate false, the false value will propogate back to the top.
    return isBST(tree.leftChild, min: min, max: tree.value) &&
      isBST(tree.rightChild, min: tree.value, max: max)
  }
}
//: [Next Challenge](@next)

