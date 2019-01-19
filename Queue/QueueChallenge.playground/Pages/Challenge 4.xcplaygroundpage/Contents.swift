// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
//: [Previous Challenge](@previous)
/*:
 ## Challenge 4:
 
 Implement a method to reverse the contents of a queue.
 
 > Hint: The `Stack` data structure has been included in the **Sources** folder.
 */
extension QueueArray {
    
  func reversed() -> QueueArray {
    var copy = self
    var stack = Stack<Element>()
    
    while !copy.isEmpty {
      var dequeuedElement = copy.dequeue()
      stack.push(dequeuedElement!)
    }
    
    while !stack.isEmpty {
      var poppedElement = stack.pop()
      copy.enqueue(poppedElement!)
    }
    
    return copy // return a copy of the reversed queue
  }
  
  // Answer from the book
//  func reversed() -> QueueArray {
//    var queue = self // 1
//    var stack = Stack<T>() // 2
//    while let element = queue.dequeue() { // 3
//      stack.push(element)
//    }
//    while let element = stack.pop() { // 4
//      queue.enqueue(element)
//    }
//    return queue // 5
//  }
}

var queue = QueueArray<String>()
queue.enqueue("1")
queue.enqueue("21")
queue.enqueue("18")
queue.enqueue("42")

print("before: \(queue)")
print("after: \(queue.reversed())")
