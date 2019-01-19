// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Queue Data Structure Challenges
 
 ## Challenge 3
 
 Imagine that you are playing a game of Monopoly with your friends. The problem
 is that everyone always forget whose turn it is! Create a Monopoly organizer
 that always tells you whose turn it is. Below is a protocol that you can
 conform to:
 */

public protocol BoardGameManager {
  
  associatedtype Player
  mutating func nextPlayer() -> Player?
}

// My Answer
extension QueueArray: BoardGameManager {
  public typealias Player = Element
  
  public mutating func nextPlayer() -> T? {
    var dequeuedElement = self.dequeue()
    self.enqueue(dequeuedElement!)
    
    return self.peek
  }
}

// Answer from the book
//extension QueueArray: BoardGameManager {
//
//  public typealias Player = T
//
//  public mutating func nextPlayer() -> T? {
//    // Get the next player by calling dequeue. If the queue is empty, simply return nil.
//    guard let person = dequeue() else { // 1
//      return nil
//    }
//    // enqueue the same person, this puts the player at the end of the queue.
//    enqueue(person) // 2
//    return person // 3
//  }
//}

var queue = QueueArray<String>()
queue.enqueue("Vincent")
queue.enqueue("Remel")
queue.enqueue("Lukiih")
queue.enqueue("Allison")
print(queue)

print("===== boardgame =======")
queue.nextPlayer()
print(queue)
queue.nextPlayer()
print(queue)
queue.nextPlayer()
print(queue)
queue.nextPlayer()
print(queue)

//: [Next Challenge](@next)
