// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # Heap Data Structure Challenges
 ## Challenge 1:
 Write a function to find the `nth` smallest integer in an unsorted array. For example:
 ```
  let integers = [3, 10, 18, 5, 21, 100]
  n = 3
 ```
 If  `n = 3`, the result should be `10`.
 */

func getNthSmallestElement(n: Int, elements: [Int]) -> Int? {
  // Initialize a min-heap with the unsorted array.
  var heap = Heap(sort: <, elements: elements)
  // current tracks the nth smallest element.
  var current = 1
  // As long as the heap is not empty, continue to remove elements.
  while !heap.isEmpty {
    // Remove the root element from the heap.
    let element = heap.remove()
    // Check to see if you reached the nth smallest element. if so, return the element.
    if current == n {
      return element
    }
    // If not, increment current.
    current += 1
  }
  // Return nil if the heap is empty.
  return nil
}

let elements = [3, 10, 18, 5, 21, 100]
let nthElement = getNthSmallestElement(n: 3, elements: elements)

//: [Next Challenge](@next)
