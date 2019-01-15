import Foundation

/*
 LinkedList
 1. Head - The first node
 2. tail - Tha last node
 
 Adding Operations:
 1. push O(1): Adds a value at the front of the list.
 2. append O(1): Adds a value at the end of the list.
 3. 1) node(at:) O(i): Tries to retrieve a node in the list based on the given index
    2) insert(after:) O(1): Adds a value after a particular node of the list.
 
 Removing Operations:
 1. pop O(1): Removes the value at the front of the list.
 2. removeLast O(n): Removes the value at the end of the list.
 3. remove(after:) O(1): Removes a value anywhere in the list.
 
 Key points:
 1. Linked lists are linear and unidirectional.
    As soon as you move a reference from one node to another, you can't go back.
 2. Linked lists have a O(1) time complexity for head first insertions.
    Arrays have O(n) time complexity for head-first insertions.
 3. Conforming to Swift collection protocols such as Sequence and Collection
      offers a host of helpful methods for a fairly small amount of requirements.
 4. Copy-on-write behavior lets you achieve value semantics.
 */

public struct LinkedList<Value> {
  
  public var head: Node<Value>?
  public var tail: Node<Value>?
  
  public init() {}
  
  public var isEmpty: Bool {
    return head == nil
  }
}

extension LinkedList: CustomStringConvertible {
  
  public var description: String {
    guard let head = head else {
      return "Empty list"
    }
    return String(describing: head)
  }
  
  public mutating func push(_ value: Value) {
    // Add a new node at the front
    head = Node(value: value, next: head)
    // If tail is nil, the new node would be both head and tail
    if tail == nil {
      tail = head
    }
  }
  
  public mutating func append(_ value: Value) {
    // 1 If it's empty, Node is going to be head and tail
    guard !isEmpty else {
      push(value)
      return
    }
    
    // 2 Add the new Node next to tail
    tail!.next = Node(value: value)
    
    // 3 Make the new node tail
    tail = tail!.next
  }
  
  // Finding the particular node
  public func node(at index: Int) -> Node<Value>? {
    // 1 Create a ref to head
    var currentNode = head
    var currentIndex = 0
    
    // 2 Move the ref until it reaches the index
    while currentNode != nil && currentIndex < index {
      currentNode = currentNode!.next
      currentIndex += 1
    }
    
    return currentNode
  }
  
  @discardableResult
  public mutating func insert(_ value: Value,
                              after node: Node<Value>)
    -> Node<Value> {
      // If the node is the tail, just append the value and return the tail
      guard tail !== node else {
        append(value)
        return tail!
      }
      // Create a new node with the value
      // Note: node.next means nil
      node.next = Node(value: value, next: node.next)
      return node.next!
  }
  
  @discardableResult
  public mutating func pop() -> Value? {
    // defer will be garanteed to be executed no matter how the func returns
    // defer will be executed after the func returns, but before it completes
    defer {
      head = head?.next
      if isEmpty {
        tail = nil
      }
    }
    return head?.value
  }
  
  @discardableResult
  public mutating func removeLast() -> Value? {
    // This means the list is empty
    guard let head = head else {
      return nil
    }
    // If head.next is nil, the list contains only one node.
    guard head.next != nil else {
      return pop()
    }
    
    // prev: It would be the node right before the last node
    // current: It would be the last node
    var prev = head
    var current = head
    
    while let next = current.next {
      prev = current
      current = next
    }
    
    // Since current is the last node, prev will be the new tail
    prev.next = nil
    tail = prev
    return current.value
  }
  
  @discardableResult
  public mutating func remove(after node: Node<Value>) -> Value? {
    defer {
      if node.next === tail {
        tail = node
      }
      // If node.next is tail, node.next would be nil, otherwise node is connected with node.next?.next
      // As a result, the node which is in-between node and node.next.next is skipped (removed).
      node.next = node.next?.next
    }
    return node.next?.value
  }
  
  // This method will replace the existing nodes of your linked list with newly allocated ones with the same value.
  private mutating func copyNodes() {
    // isKnownUniquelyReferenced is a Swift standard library func that
    //   determines whether or not an object has exactly one reference to it
    guard !isKnownUniquelyReferenced(&head) else {
      return
    }
    
    guard var oldNode = head else {
      return
    }
    
    head = Node(value: oldNode.value)
    var newNode = head
    
    while let nextOldNode = oldNode.next {
      newNode!.next = Node(value: nextOldNode.value)
      newNode = newNode!.next
      
      oldNode = nextOldNode
    }
    
    tail = newNode
  }
}

extension LinkedList: Collection {
  
  // Star index is defined by the head of the list
  public var startIndex: Index {
    return Index(node: head)
  }
  
  // The last index should be the index right after the last accessible value
  // This is like a string in C language
  public var endIndex: Index {
    return Index(node: tail?.next)
  }
  
  // Dictates how the index can be incremented
  public func index(after i: Index) -> Index {
    return Index(node: i.node?.next)
  }
  
  // The subscript is used to map an Index to the value in the collection
  public subscript(position: Index) -> Value {
    return position.node!.value
  }
  
  // Custom Index
  public struct Index: Comparable {
    
    public var node: Node<Value>?
    
    static public func ==(lhs: Index, rhs: Index) -> Bool {
      switch (lhs.node, rhs.node) {
      case let (left?, right?):
        return left.next === right.next
      case (nil, nil):
        return true
      default:
        return false
      }
    }
    
    static public func <(lhs: Index, rhs: Index) -> Bool {
      guard lhs != rhs else {
        return false
      }
      let nodes = sequence(first: lhs.node) { $0?.next }
      return nodes.contains { $0 === rhs.node }
    }
  }
  
}
