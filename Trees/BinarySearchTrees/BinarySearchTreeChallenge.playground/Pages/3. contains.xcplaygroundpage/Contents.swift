// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ### Challenge 3
 Create a method that checks if the current tree contains all the elements of another tree.
 */

var bst = BinarySearchTree<Int>()
bst.insert(3)
bst.insert(1)
bst.insert(4)
bst.insert(0)
bst.insert(2)
bst.insert(5)

var bst2 = BinarySearchTree<Int>()
bst2.insert(2)
bst2.insert(5)
bst2.insert(3)
bst2.insert(1)
bst2.insert(0)
// bst2.insert(100)

// Your solution here

// You'll make use of a Set for this solution.
// To insert elements into a Set, the elements must be Hashable,
//  so you first constrain the extension where Element is Hashable.
extension BinarySearchTree where Element: Hashable {
  public func contains(_ subtree: BinarySearchTree) -> Bool {
    
    // Inside the contains function,
    //  you begin by inserting all the elements of the current tree into the set.
    var set: Set<Element> = []
    root?.traverseInOrder {
      set.insert($0)
    }
    
    // isEqual is to store the end result.
    // The reason you need this is because traverseInOrder takes
    //  a closure and you cannot directly return from inside the closure.
    var isEqual = true
    
    // For every element in the subtree, you check if the value is contained in the set.
    // If at any point set.contains($0) evaluates as false,
    //  you'll make sure isEqual stays false even if subsequent elements evaluate
    //   as true by assigning isEqual && set.contains($0) to itself.
    subtree.root?.traverseInOrder {
      isEqual = isEqual && set.contains($0)
    }
    return isEqual
  }
}

// bst.contains(bst2)

