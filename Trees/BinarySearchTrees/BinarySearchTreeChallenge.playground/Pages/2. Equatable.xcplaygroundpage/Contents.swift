// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ### Challenge 2
 The binary search tree currently lacks `Equatable` conformance. Your challenge is to conform adopt the `Equatable` protocol.
 */

var bst = BinarySearchTree<Int>()
bst.insert(3)
bst.insert(1)
bst.insert(4)
bst.insert(0)
bst.insert(2)
bst.insert(5)

print(bst)

var bst2 = BinarySearchTree<Int>()
bst2.insert(2)
bst2.insert(5)
bst2.insert(3)
bst2.insert(1)
bst2.insert(0)
bst2.insert(4)

// Are bst1 and bst2 equal?
// Your solution here
extension BinarySearchTree: Equatable {
  // This is the function that the Equatable protocol requires.
  // Inside the function, you'll return the result from the isEqual helper function.
  public static func ==(lhs: BinarySearchTree,
                        rhs: BinarySearchTree) -> Bool {
    return isEqual(lhs.root, rhs.root)
  }
  
  // isEqual will recursively check two nodes and its descendents for equality.
  private static func isEqual<Element: Equatable>(
    _ node1: BinaryNode<Element>?,
    _ node2: BinaryNode<Element>?) -> Bool {
    
    // This is the base case. If one or more of the nodes are nil,
    //  then there's no need to continue checking.
    // If both nodes are nil, they are equal.
    // Otherwise, one is nil and one isn't nil, so they must not be equal.
    guard let leftNode = node1,
      let rightNode = node2 else {
        return node1 == nil && node2 == nil
    }
    
    // Here, you check the value of the left and right nodes for equality.
    // You also recursively check the left children and right children for equality.
    return leftNode.value == rightNode.value &&
      isEqual(leftNode.leftChild, rightNode.leftChild) &&
      isEqual(leftNode.rightChild, rightNode.rightChild)
  }
}
//: [Next Challenge](@next)
