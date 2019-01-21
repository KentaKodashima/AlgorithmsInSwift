// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 2
 
 A common task in software development is serializing an object into another
 data type. This process is known as serialization, and allows custom types to
 be used in systems that only support a closed set of data types.
 
 An example of serialization is JSON. Your task is to devise a way to serialize
 a binary tree into an array, and a way to deserialize the array back into
 the same binary tree.
 
 To clarify this problem, consider the following binary tree:
 
 ![Binary Tree](binary-tree.png)
 
 A particular algorithm may output the serialization as
 `[15, 10, 5, nil, nil, 12, nil, nil, 25, 17, nil, nil, nil]`.
 The deserialization process should transform the array back into the same
 binary tree. Note that there are many ways to perform serialization.
 You may choose any way you wish.
 */

var tree: BinaryNode<Int> = {
  
  let root = BinaryNode(value: 15)
  let ten = BinaryNode(value: 10)
  let five = BinaryNode(value: 5)
  let twelve = BinaryNode(value: 12)
  let twentyFive = BinaryNode(value: 25)
  let seventeen = BinaryNode(value: 17)
  
  root.leftChild = ten
  root.rightChild = twentyFive
  ten.leftChild = five
  ten.rightChild = twelve
  twentyFive.leftChild = seventeen
  
  return root
}()

print(tree)

extension BinaryNode {
  // Traverse each node and visit the node before traversing the children
  // Visit the nil nodes since it's important to record those for serialization and deserialization
  public func traversePreOrder(visit: (Element?) -> Void) {
    visit(value)
    if let leftChild = leftChild {
      leftChild.traversePreOrder(visit: visit)
    } else {
      visit(nil)
    }
    if let rightChild = rightChild {
      rightChild.traversePreOrder(visit: visit)
    } else {
      visit(nil)
    }
  }
}

// Serialization O(n)
// Simply traverse the tree and store the values into an array.
// The elements of the array have type T? to keep track of the nil nodes.
// Return a new array containing the values of the tree in pre-order.
func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
  var array: [T?] = []
  node.traversePreOrder { array.append($0) }
  return array
}

// Deserialization: O(n)
// The deserialization process is to take each value of the array and reassemble it back to the tree.
// The goal is to iterate through the array and reassemble the tree in pre-order format.

// The deserialize function takes an inout array of values.
// This is important because you'll be able to make mutations
//  to the array in each recursive step and allow future recursive calls to see the changes.
// To know more about 'inout', visit https://docs.swift.org/swift-book/ReferenceManual/Declarations.html#ID545
func deserialize<T>(_ array: inout [T?])
  -> BinaryNode<T>? {
    
    // If removeFirst returns nil, there are no more elements in the array,
    //  thus the recursion ends here.
    guard let value = array.removeLast() else {
      return nil
    }
    
    // Reassemble the tree by creating a node from the current value,
    //  and recursively calling deserialize to assign nodes to the left and right children
    // This is very similar to the pre-order traversal,
    //  except you are building nodes rather than extracting their values
    let node = BinaryNode(value: value)
    node.leftChild = deserialize(&array)
    node.rightChild = deserialize(&array)
    return node
}

// Helper function that first reverses the array before calling the main deserialize function
func deserialize<T>(_ array: [T?]) -> BinaryNode<T>? {
  var reversed = Array(array.reversed())
  return deserialize(&reversed)
}

var array = serialize(tree)
let node = deserialize(array)
print(node!)
