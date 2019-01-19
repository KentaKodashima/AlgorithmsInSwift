import Foundation

/*
 Callenge 1:
  Explain the difference between a stack and a queue.
  Provide two real-life examples for each data structure.
 
 Answer:
  Stack is a LIFO structure. It's like piling up the books on the table.
    When you put a book, you put it on the top.
    When you take a book, you first remove the book on the top
      no matter which book you want to take.
 
  Queue is a FIFO structure. It's like a line for the movie theatre.
    You join the end of the line to buy a ticket.
    After you buy the ticket, you're out of the line.
 
 Challenge 2:
  Given the following queue: "SWIFT"
  Provide step-by-step diagrams showing how the following series of commands affects the queue:
   enqueue("R")
   enqueue("O")
   dequeue()
   enqueue("C")
   dequeue()
   dequeue()
   enqueue("K")
  Do this for the following queue implementations:
   Array-based
   Linked list
   Ring buffer
   Stack based
   Assume that the array and ring buffer have an initial size of 5.
 
 Answer:
   Array-based:
     enqueue("R"): SWIFTR - Add 'R' at the end
     enqueue("O"): SWIFTRO - Add 'O' at the end
     dequeue(): WIFTRO - Remove 'S' from the front
     enqueue("C"): WIFTROC - Add 'C' at the end
     dequeue(): IFTROC - Remove 'W' from the front
     dequeue(): FTROC - Remove 'I' from the front
     enqueue("K"): FTROCK - Add 'K' from the front
 
   Linked list:
     enqueue("R"): SWIFTR - Add 'R' at the end
     enqueue("O"): SWIFTRO - Add 'O' at the end
     dequeue(): WIFTRO- Remove 'S' from the front
     enqueue("C"): WIFTROC - Add 'C' at the end
     dequeue(): IFTROC - Remove 'W' from the front
     dequeue(): FTROC - Remove 'I' from the front
     enqueue("K"): FTROCK - Add 'K' from the front
 
   Ring buffer:
     enqueue("R"): RWIFT - Override 'S' with 'R'
     enqueue("O"): ROIFT - Override 'W' with 'O'
     dequeue(): OIFT - Increment the read pointer to the right
     enqueue("C"): OIFTC - Write 'C' at the end
     dequeue(): IFTC - Increment the read pointer to the right
     dequeue(): FTC - Increment the read pointer to the right
     enqueue("K"): FTCK - Write 'K' at the end
 
   Stack based:
     enqueue("R"): SWIFTR - Add 'R' to the right stack
     enqueue("O"): SWIFTRO - Add 'O' to the right stack
     dequeue(): WIFTRO - Reverse the right stack and copy it to the left stack, then removeAll() from the right stack
     enqueue("C"): WIFTROC - Add 'C' to the right stack
     dequeue(): IFTROC - Remove 'W' from the left stack
     dequeue(): FTROC - Remove 'I' from the left stack
     enqueue("K"): FTROCK - Add 'K' to the right stack
 */
