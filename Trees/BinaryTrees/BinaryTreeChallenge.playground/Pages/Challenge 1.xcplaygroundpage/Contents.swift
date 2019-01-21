// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Binary Tree Challenges
 
 ## Challenge 1
 Given a binary tree, find the height of the tree. The height of the binary tree
 is determined by the distance between the root and the furthest leaf. The
 height of a binary tree with a single node is zero, since the single node is
 both the root and the furthest leaf.
 */

var tree: BinaryNode<Int> = {
  let zero = BinaryNode(value: 0)
  let one = BinaryNode(value: 1)
  let five = BinaryNode(value: 5)
  let seven = BinaryNode(value: 7)
  let eight = BinaryNode(value: 8)
  let nine = BinaryNode(value: 9)
  
  seven.leftChild = one
  one.leftChild = zero
  one.rightChild = five
  seven.rightChild = nine
  nine.leftChild = eight
  
  return seven
}()

print(tree)

// O(n) Algorithm to get the height of a binary node tree
func height<T>(of node: BinaryNode<T>?) -> Int {
  
  // If the node is nil, return -1
  guard let node = node else {
    return -1
  }
  
  // max<T>(_ x: T, _ y: T) returns the greater of two comparable values.
  return 1 + max(height(of: tree.leftChild), height(of: tree.rightChild))
}
 print(height(of: tree))

//: [Next Challenge](@next)
