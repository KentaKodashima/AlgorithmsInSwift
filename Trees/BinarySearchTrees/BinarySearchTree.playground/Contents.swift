// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Binary Search Tree:
 A binary search tree, or BST, is a data structure that facilitates fast lookup,
  insert and removal operations.
 A binary search tree imposes two rules on the binary tree:
  1. The value of a left child must be less than the value of its parent.
  2. Consequently, the value of a right child must be greater than
      or equal to the value of its parent.
 
 Lookup, insert and removal have an average time complexity of O(log n),
  which is considerably faster than linear data structures such as arrays and linked lists.
 
 Array VS. BST
 Array
  - Lookup:
    Check every element in the array from the start.
    This is why array.contains(:) is an O(n) operation.
  - Insertion:
    
 BST
  - Lookup:
     - If the search value is less than the current value, it must be in the left subtree.
     - If the search value value is greater than the current value, it must be in the right subtree.
 */
