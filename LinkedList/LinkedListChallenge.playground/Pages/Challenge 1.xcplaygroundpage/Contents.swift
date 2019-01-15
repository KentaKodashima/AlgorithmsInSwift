// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Linked List Challenges
 ## Challenge 1:
 Create a function that prints out the elements of a Linked List in reverse order.
 */
// Prints out the list
func printInReverse<T>(_ list: LinkedList<T>) {
  printInReverse(list.head)
}

// Prints out each nodes
func printInReverse<T>(_ node: Node<T>?) {
  guard let node = node else { return }
  // Keeps on going until it reaches the end
  // It stacks the process
  printInReverse(node.next)
  print(node.value)
}

example(of: "printing in reverse") {
  var list = LinkedList<Int>()
  list.push(3)
  list.push(2)
  list.push(1)

  print("Original list: \(list)")
  print("Printing in reverse:")
  printInReverse(list)
}
//: [Next Challenge](@next)
