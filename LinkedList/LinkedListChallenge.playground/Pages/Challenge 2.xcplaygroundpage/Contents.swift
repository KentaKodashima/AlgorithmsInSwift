// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 2:
 Create a function that returns the middle node of a Linked List.
 */

func getMiddle<T>(_ list: LinkedList<T>) -> Node<T>? {
  var slow = list.head
  var fast = list.head
  
  // fast will move faster
  while let nextFast = fast?.next {
    fast = nextFast.next
    slow = slow?.next
  }
  
  return slow
}

example(of: "printing in reverse") {
  var list = LinkedList<Int>()
  list.push(3)
  list.push(2)
  list.push(1)
  
  print("Original list: \(list)")
  print(getMiddle(list))
}

//: [Next Challenge](@next)
