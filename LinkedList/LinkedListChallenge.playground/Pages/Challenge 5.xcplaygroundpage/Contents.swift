// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 5:
 Create a function that removes all occurrences of a specific element from a Linked List.
 */

extension LinkedList where Value: Equatable {
  
  mutating func removeAll(_ value: Value) {
    // Deal with the case where the head of the list contains the value you want to remove
    while let head = head, head.value == value {
      self.head = head.next
    }
    
    var prev = head
    var current = head?.next
    while let currentNode = current {
      guard currentNode.value != value else {
        // Skip the currentNode
        prev?.next = currentNode.next
        // Move current 1 to the right
        current = prev?.next
        continue
      }
      // Move prev and current 1 to the right to guarantee that while loop terminates
      prev = current
      current = current?.next
      // Handle the case where the original tail is a node containing the value you wanted to remove
      tail = prev
    }
  }
}

example(of: "deleting duplicate nodes") {
  var list = LinkedList<Int>()
  list.push(3)
  list.push(2)
  list.push(2)
  list.push(1)
  list.push(1)

  list.removeAll(3)
  print(list)
}
