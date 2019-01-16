// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Array Based Implemetation
 Implementation of Queue using Swift Array.
 
 Strength:
  - Enqueue is very fast, thanks to an O(1) append operation
  - Easy to implement
 
 Weakness:
  - Removing an item from the front of the queue can be inefficient,
     as removal causes all elements to shift up by one
  - Once the array gets full, it has to resize and may have unused space.
    This could increase your memory footprint over time.
 */

// Generic QueueArray struct that adopts the Queue protocol
public struct QueueArray<T>: Queue {
  private var array: [T] = []
  public init() {}
  
  // Check if the queue is empty.
  public var isEmpty: Bool {
    return array.isEmpty // 1
  }
  
  // Return the element at the front of the queue.
  public var peek: T? {
    return array.first // 2
  }
  
  // Adding an element to the back of the queue
  /*
   Note:
   After adding multiple elements, the array will eventually be full.
   When you want to use more than the allocated space, the array must resize to make additional room.
   
   Resizing is an O(n) operation. Resizing requires the array to allocate new memory and copy all existing data over to the new array. When it copies, it doubles the size.
  */
  public mutating func enqueue(_ element: T) -> Bool {
    array.append(element)
    return true
  }
  
  /*
   To dequeue, you remove the element from the beginning of the array.
   This is always a linear time operation,
     because it requires all the remaining elements in the array to be shifted in memory.
  */
  public mutating func dequeue() -> T? {
    return isEmpty ? nil : array.removeFirst()
  }
}

extension QueueArray: CustomStringConvertible {
  public var description: String {
    return String(describing: array)
  }
}

var queue = QueueArray<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue
queue.dequeue()
queue
queue.peek
