// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 <AVL Trees>
 In 1962, Georgy Adelson-Velsky and Evgenii Landis came up with
  the first self-balancing binary search tree: The AVL Tree.
 AVL trees maintain balance by adjusting the structure of the tree when the tree becomes unbalanced.
 
 Understanding Balance:
  - Perfect balance:
    The ideal form of a binary search tree.
    This means every level of the tree is filled with nodes, from top to bottom.
    Not only is the tree perfectly symmetrical, the nodes at the bottom level are completely filled.
    This is the requirement for being perfectly balanced.
  - "Good-enough" balance:
    The definition of a balanced tree is that every level of the tree must be filled,
     except for the bottom level. In most cases of binary trees, this is the best you can do.
  - Unbalance:
    Binary search trees in this state suffer from various levels of performance loss,
     depending on the degree of imbalance.
 
 Measuring Balance:
  - The height property, the longest distance from the current node to a leaf node
  - The height of the left and right children of each node must differ at most by 1.
    This is known as the balance factor.
  - Although more than one node may have a bad balancing factor,
     you only need to perform the balancing procedure
      on the bottom-most node containing the invalid balance factor.
 
 Rotation:
  The procedures used to balance a binary search tree.
  There are four rotations in total, for the four different ways that a tree can become unbalanced.
  These are known as left rotation, left-right rotation, right rotation and right-left rotation.
 
  - Left rotation:
    Left rotation is the symmetrical opposite of right rotation.
    When a series of right children is causing an imbalance, it’s time for a left rotation.
  - Right rotation:
    Right rotation is the symmetrical opposite of left rotation.
    When a series of left children is causing an imbalance, it’s time for a Right rotation.
  - Right-left toration:
    The left and right rotations balance nodes that are all left children or all right children.
    Performing a right rotation on the right child before doing the left rotation solves the problem,
     if the tree has mixed missing cases such as the case
      the child is missing right although the parent node is missing left.
  - Left-right rotation
    Left-right rotation is the symmetrical opposite of the right-left rotation.
 
 Key points:
  - A self-balancing tree avoids performance degradation
     by performing a balancing procedure whenever you add or remove elements in the tree.
  - AVL trees preserve balance by readjusting parts of the tree when the tree is no longer balanced.
 */

example(of: "repeated insertions in sequence") {
  var tree = AVLTree<Int>()
  for i in 0..<15 {
    tree.insert(i)
  }
  print(tree)
}

example(of: "removing a value") {
  var tree = AVLTree<Int>()
  tree.insert(15)
  tree.insert(10)
  tree.insert(16)
  tree.insert(18)
  print(tree)
  tree.remove(10)
  print(tree)
}
