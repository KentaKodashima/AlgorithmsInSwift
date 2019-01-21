// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
//: # General Tree Challenge
//: Print all the values in a tree in an order based on their level.
//: Nodes belonging in the same level should be printed in the same line.
//: For example, consider the following tree:
//:
//: ![Image of Tree](tree.png)
//:
//: Your algorithm should output the following in the console:
//:
//: ```none
//: 15
//: 1 17 20
//: 1 5 0 2 5 7
//: ```
//:
//: **Hint**: Consider using a `Queue` included for you in **Sources**.
// Build the sample tree shown in the diagram
// Root of the tree
let tree = TreeNode(15)

// Second level
let one = TreeNode(1)
tree.add(one)

let seventeen = TreeNode(17)
tree.add(seventeen)

let twenty = TreeNode(20)
tree.add(twenty)

// Third level
let one2 = TreeNode(1)
let five = TreeNode(5)
let zero = TreeNode(0)
one.add(one2)
one.add(five)
one.add(zero)

let two = TreeNode(2)
seventeen.add(two)

let five2 = TreeNode(5)
let seven = TreeNode(7)
twenty.add(five2)
twenty.add(seven)

// Your solution here
func printEachLevel<T>(for tree: TreeNode<T>) {
  // Initialize a Queue data structure to facilitate the level order traversal
  // nodesLeftInCurrentLevel to keep track of
  //  the number of nodes you'll need to work on before you print a new line.
  var queue = Queue<TreeNode<T>>()
  var nodesLeftInCurrentLevel = 0
  queue.enqueue(tree)
  
  // Level-order traversal continues until your queue is empty.
  while !queue.isEmpty {
    // Set nodesLeftInCurrentLevel to the current elements in the queue.
    nodesLeftInCurrentLevel = queue.count
    
    while nodesLeftInCurrentLevel > 0 {
      // Dequeue the first nodesLeftInCurrentLevel number of elements from the queue
      guard let node = queue.dequeue() else { break }
      // Every element you dequeue is printed out without establishing a new line
      print("\(node.value) ", terminator: "")
      // Enqueue all the children of the node
      node.children.forEach { queue.enqueue($0) }
      nodesLeftInCurrentLevel -= 1
    }
    // Generate the new line using print()
    print()
  }
}
