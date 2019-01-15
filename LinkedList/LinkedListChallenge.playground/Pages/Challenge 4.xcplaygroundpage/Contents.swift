// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 4:
 Create a function that takes 2 sorted linked lists and merges them into a single sorted linked list.
 */

func mergeSorted<T: Comparable>(_ left: LinkedList<T>,
                                _ right: LinkedList<T>) -> LinkedList<T> {
  // If left isEmpty, just returns right
  guard !left.isEmpty else {
    return right
  }
  
  // If right isEmpty, just returns left
  guard !right.isEmpty else {
    return left
  }
  
  var newHead: Node<T>?
  
  var tail: Node<T>?
  var currentLeft = left.head
  var currentRight = right.head
  
  // Compares the first nodes of left and right to assign newHead
  if let leftNode = currentLeft, let rightNode = currentRight {
    if leftNode.value < rightNode.value {
      newHead = leftNode
      currentLeft = leftNode.next
    } else {
      newHead = rightNode
      currentRight = rightNode.next
    }
    tail = newHead
  }
  
  // While loop continue until one of the list reaches the end
  while let leftNode = currentLeft, let rightNode = currentRight {
    // If leftNode is bigger, assign leftNode to tail.next and tail would be tail?.next(leftNode)
    // If rightNode is bigger, assign rightNode to tail.next and tail would be tail?.next(rightNode)
    if leftNode.value < rightNode.value {
      tail?.next = leftNode
      currentLeft = leftNode.next
    } else {
      tail?.next = rightNode
      currentRight = rightNode.next
    }
    tail = tail?.next
  }
  
  // Appends the remainder of the nodes from left
  if let leftNodes = currentLeft {
    tail?.next = leftNodes
  }
  
  // Appends the remainder of the nodes from right
  if let rightNodes = currentRight {
    tail?.next = rightNodes
  }
  
  var list = LinkedList<T>()
  list.head = newHead
  // tail?.next might not be nil after appeding the remainders
  list.tail = {
    while let next = tail?.next {
      tail = next
    }
    return tail
  }()
  return list
}

example(of: "merging two lists") {
  var list = LinkedList<Int>()
  list.push(3)
  list.push(2)
  list.push(1)
  var anotherList = LinkedList<Int>()
  anotherList.push(-1)
  anotherList.push(-2)
  anotherList.push(-3)
  print("First list: \(list)")
  print("Second list: \(anotherList)")
  let mergedList = mergeSorted(list, anotherList)
  print("Merged list: \(mergedList)")
}

//: [Next Challenge](@next)
