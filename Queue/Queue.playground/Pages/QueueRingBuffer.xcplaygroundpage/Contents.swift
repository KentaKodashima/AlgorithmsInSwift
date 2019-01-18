// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Ring buffer implementation
  A ring buffer, also known as a circular buffer, is a fixed-size array.
  This data structure strategically wraps around
    to the beginning when there are no more items to remove at the end.
 
 Two pointers in a ring buffer
  1. Read
    The read pointer keeps track of the front of the queue.
  2. Write
    The write pointer keeps track of the next available slot
      so that you can override existing elements that have already been read.
 
 Core operations:
  - enque
    The write pointer moves to the next available slot.
  - dequeue
    The read pointer moves to the end.
 
    Note: Whenever the read and write pointers are at the same index, that means the queue is empty.
 
 Strength:
 - The ring buffer has a fixed size, which means you don't have to worry about memory
 
 Weakness:
  - Enqueue can fail because the ring buffer has a fixed size
 */

public struct QueueRingBuffer<T>: Queue {
  
  private var ringBuffer: RingBuffer<T>
  
  public init(count: Int) {
    ringBuffer = RingBuffer<T>(count: count)
  }
  
  public var isEmpty: Bool {
    return ringBuffer.isEmpty
  }
  
  public var peek: T? {
    return ringBuffer.first
  }
  
  public mutating func enqueue(_ element: T) -> Bool {
    return ringBuffer.write(element)
  }
  
  public mutating func dequeue() -> T? {
    //the ring buffer increments the read pointer by one
    return isEmpty ? nil : ringBuffer.read()
  }
}

extension QueueRingBuffer: CustomStringConvertible {
  public var description: String {
    return String(describing: ringBuffer)
  }
}

var queue = QueueRingBuffer<String>(count: 10)
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue
queue.dequeue()
queue
queue.peek
