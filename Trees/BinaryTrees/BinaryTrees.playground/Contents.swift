// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Binary Tree:
 A binary tree is a tree in which each node has at most two children,
  often referred to as the left and right children.
 
 Traversal Algorithms
 1. In-order traversal: O(n)
    In-order traversal visits the nodes of a binary tree in the following order,
      starting from the root node:
      - If the current node has a left child, recursively visit this child first.
      - Then visit the node itself.
      - If the current node has a right child, recursively visit this child.
    This can be used to visit the nodes in acsending order
 2. Pre-order traversal: O(n)
    Pre-order traversal always visits the current node first,
      then recursively visits the left and right child.
 3. Post-order traversal: O(n)
    Post-order traversal only visits the current node
      after the left and right child have been visited recursively.
    In other words, given any node, you’ll visit its children before visiting itself.
    An interesting consequence of this is that the root node is always visited last
 
 Key Points:
  - The binary tree is the foundation to some of the most important tree structures.
    The binary search tree and AVL tree are binary trees
      that impose restrictions on the insertion/deletion behaviors.
  - In-order, pre-order and post-order traversals aren't just important only for the binary tree;
      if you're processing data in any tree, you'll interface with these traversals regularly.
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

example(of: "tree diagram") {
  print(tree)
}

example(of: "in-order traversal") {
  tree.traverseInOrder { print($0) }
}

example(of: "pre-order traversal") {
  tree.traversePreOrder { print($0) }
}

example(of: "post-order traversal") {
  tree.traversePostOrder { print($0) }
}
