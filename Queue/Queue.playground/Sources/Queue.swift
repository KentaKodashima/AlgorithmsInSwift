// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Queue
  Queues use FIFO or first-in first-out ordering,
    meaning the first element that was added will always be the first to be removed.
 
 Core Operations:
  - enqueue: Insert an element at the back of the queue. Returns true if the operation was successful.
  - dequeue: Remove the element at the front of the queue and return it.
  - isEmpty: Check if the queue is empty.
  - peek: Return the element at the front of the queue without removing it.
 
 Use case:
  Queues are handy when you need to maintain the order of your elements to process later.
 */

public protocol Queue {
  
  associatedtype Element
  mutating func enqueue(_ element: Element) -> Bool
  mutating func dequeue() -> Element?
  var isEmpty: Bool { get }
  var peek: Element? { get }
}
