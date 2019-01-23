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
     - Check every element in the array from the start.
     - This is why array.contains(:) is an O(n) operation.
  - Insertion:
     - Inserting values into an array is like butting into an existing line:
        Everyone in the line behind your chosen spot needs to make space for you by shuffling back.
     - This is an O(n) operation.
  - Removal:
     - Similar to insertion, removing an element in an array also triggers a shuffling of elements:
        This behavior also plays nicely with the lineup analogy. If you leave the middle of the line,
         everyone behind you needs to shuffle forward to take up the empty space.
 
 BST
  - Lookup:
     - If the search value is less than the current value, it must be in the left subtree.
     - If the search value value is greater than the current value, it must be in the right subtree.
  - Inserting:
     - Inserting elements in a BST is again an O(log n) operation, thanks to BST rules.
  - Removal:
     - Removal of elements in a BST is again an O(log n) operation, thanks to BST rules.
      *Note: There are complications to manage when the node you’re removing has children.
 
 Key Points:
  - The binary search tree is a powerful data structure for holding sorted data.
  - Average performance for insert, remove and contains methods in a BST is O(log n).
  - Performance will degrade to O(n) as the tree becomes unbalanced. This is undesireable,
     so you'll learn about a self-balancing binary search tree called the AVL tree in the next chapter.
 */

// NOTE:
// Automatically Run mode is more like running an entire program, whereas manual run is not.
var exampleTree: BinarySearchTree<Int> {
  var bst = BinarySearchTree<Int>()
  
  bst.insert(3)
  bst.insert(1)
  bst.insert(4)
  bst.insert(0)
  bst.insert(2)
  bst.insert(5)
  
  return bst
}

example(of: "building a BST") {
  print(exampleTree)
}

//example(of: "building a BST") {
//  var bst = BinarySearchTree<Int>()
//  for i in 0..<5 {
//    bst.insert(i)
//  }
//  print(bst)
//}

example(of: "finding a node") {
  if exampleTree.contains(5) {
    print("Found 5!")
  } else {
    print("Couldn't find 5")
  }
}
