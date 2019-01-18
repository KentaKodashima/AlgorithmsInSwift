// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Doubly linked list
 A doubly linked list is simply a linked list
   in which nodes also contain a reference to the previous node.
 
 Strength:
  - Dequeuing an item is completed by just updating the node’s previous and next pointers.
 
 Weakness:
  - Each element has to have extra storage for the forward and back reference which leads to high overhead.
  - every time you create a new element, it requires a relatively expensive dynamic allocation.
 */

var queue = QueueLinkedList<String>()
queue.enqueue("Ray")
queue.enqueue("Brian")
queue.enqueue("Eric")
queue
queue.dequeue()
queue
queue.peek
