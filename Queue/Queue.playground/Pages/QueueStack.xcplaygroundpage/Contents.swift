// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Double-stack implementation
  Whenever you enqueue an element, it goes in the right stack.
  When you need to dequeue an element, you reverse the right stack
    and place it in the left stack so that you can retrieve the elements using FIFO order.
 
 Strength:
  - Dequeue is O(1)
  - Fully dynamic and doesn’t have the fixed size restriction
  - It beats the linked list in terms of spacial locality
    A linked list might not have the elements in contiguous blocks memory,
      while an array's elements are next to each other.
    This could lead to more cache misses, which will increase access time.
 
 Weakness:
  - reversing the contents of an array is an O(n) operation
    Imagine having a large number of items in both the left and right stack.
    If you dequeue all of the elements,
      first it will remove all of the elements from the left stack,
      then reverse-copy the right stack only once,
      and then continue removing elements off the left stack.
 
 Key points (Queue general):
  - Queue takes a FIFO strategy, an element added first must also be removed first.
  - Enqueue inserts an element to the back of the queue.
  - Dequeue removes the element at the front of the queue.
  - Elements in an array are laid out in contiguous memory blocks,
      whereas elements in a linked list are more scattered with potential for cache misses.
  - Ring-buffer-queue based implementation is good for queues with a fixed size.
  - Compared to other data structures, leveraging two stacks improves
      the dequeue(_:) time complexity to amortized O(1) operation.
  - Double-stack implementation beats out Linked-list in terms of spacial locality.
 */

public struct QueueStack<T> : Queue {
  private var leftStack: [T] = []
  private var rightStack: [T] = []
  public init() {}
  
  // This means that there are no elements left to dequeue
  //  and no new elements have been enqueued
  public var isEmpty: Bool {
    return leftStack.isEmpty && rightStack.isEmpty
  }
  
  public var peek: T? {
    return !leftStack.isEmpty ? leftStack.last : rightStack.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    // push to the right stack
    rightStack.append(element)
    return true
  }
  
  public mutating func dequeue() -> T? {
    // If the left stack is empty, set it as the reverse of the right stack.
    if leftStack.isEmpty {
      leftStack = rightStack.reversed()
      rightStack.removeAll()
    }
    return leftStack.popLast()
  }
}

extension QueueStack: CustomStringConvertible {
  public var description: String {
    let printList = leftStack.reversed() + rightStack
    return String(describing: printList)
  }
}

var queue = QueueStack<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue
queue.dequeue()
queue
queue.peek
