import Foundation

/*
 Stack
 You can only add or remove elements from one side of the data structure.
 In computer science, a stack is known as the LIFO (last-in first-out) data structure.

 Essencial Operations:
  - push: Adding an element to the top of the stack.
  - pop: Removing the top element of the stack.
 
 Non-Essencial Operations:
  - peek: Look at the top element of the stack without mutating its contents.
 
 Use cases:
  - iOS uses the navigation stack to push and pop view controllers into and out of view
  - Memory allocation uses stacks at the architectural level. Memory for local variables is also managed using a stack
  - Search and conquer algorithms, such as finding a path out of a maze, use stacks to facilitate backtracking.
 
 Key points:
  - Despite being so simple, the stack is a key data structure for many problems.
  - The only two essential operations for the stack are the push method for adding elements
      and the pop method for removing elements.
 */

public struct Stack<Element> {
  private var storage: [Element] = []
  
  public init() { }
  
  public init(_ elements: [Element]) {
    storage = elements
  }
  
  // stack an element
  public mutating func push(_ element: Element) {
    storage.append(element)
  }
  
  // pop out the top
  @discardableResult
  public mutating func pop() -> Element? {
    return storage.popLast()
  }
  
  // peek the top element
  public func peek() -> Element? {
    return storage.last
  }
  
  // check if it's empty
  public var isEmpty: Bool {
    return peek() == nil
  }
}

// Make a stack initializable with an array
extension Stack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: Element...) {
    storage = elements
  }
}

extension Stack: CustomStringConvertible {
  public var description: String {
    let topDivider = "----top----\n"
    let bottomDivider = "\n-----------"
    
    let stackElements = storage
      .map { "\($0)" }
      .reversed()
      .joined(separator: "\n")
    return topDivider + stackElements + bottomDivider
  }
}
