import Foundation

/*
 Node
 1. A node holds a value
 2. A node holds a reference to the next node.
    A nil value represents the end of the list.
 */

public class Node<Value> {
  
  public var value: Value
  public var next: Node?
  
  public init(value: Value, next: Node? = nil) {
    self.value = value
    self.next = next
  }
}

extension Node: CustomStringConvertible {
  
  public var description: String {
    guard let next = next else {
      return "\(value)"
    }
    return "\(value) -> " + String(describing: next) + " "
  }
}
