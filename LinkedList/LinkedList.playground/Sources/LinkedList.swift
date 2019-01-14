import Foundation

/*
 LinkedList
 1. Head - The first node
 2. tail - Tha last node
 
 Adding Operations:
 1. push
 2. append
 3. insert(at after:)
 
 Removing Operations:
 1. pop
 2. removeLast
 3. remove(at after:)
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
      // Create a new Node() with the value
      // Note: node.next means nil
      node.next = Node(value: value, next: node.next)
      return node.next!
  }
  
  @discardableResult
  public mutating func pop() -> Value? {
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
    // 1
    guard let head = head else {
      return nil
    }
    // 2
    guard head.next != nil else {
      return pop()
    }
    // 3
    var prev = head
    var current = head
    
    while let next = current.next {
      prev = current
      current = next
    }
    // 4
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
      node.next = node.next?.next
    }
    return node.next?.value
  }
  
  private mutating func copyNodes() {
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
  
  // 1
  public var startIndex: Index {
    return Index(node: head)
  }
  // 2
  public var endIndex: Index {
    return Index(node: tail?.next)
  }
  // 3
  public func index(after i: Index) -> Index {
    return Index(node: i.node?.next)
  }
  // 4
  public subscript(position: Index) -> Value {
    return position.node!.value
  }
  
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
