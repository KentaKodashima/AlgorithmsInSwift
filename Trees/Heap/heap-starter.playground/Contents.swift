// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Heap:
  A heap is a complete binary tree,
   also known as a binary heap, that can be constructed using an array.
 
 Heaps come in two flavors:
  - Max heap, in which elements with a higher value have a higher priority:
    In a max heap, parent nodes must always contain
     a value that is greater than or equal to the value in its children.
    The root node will always contain the highest value.
 
  - Min heap, in which elements with a lower value have a higher priority:
    In a min heap, parent nodes must always contain a value
     that is less than or equal to the value in its children.
    The root node will always contain the lowest value.
 
 The heap property
  A heap has important characteristic that must always be satisfied.
  This is known as the heap invariant or heap property.
  Another important property of a heap is that it is a complete binary tree.
  This means that every level must be filled, except for the last level.
 
 Heap Applications:
  - Calculating the minimum or maximum element of a collection.
  - Heap sort.
  - Constructing a priority queue.
  - Constructing graph algorithms, like Prim’s or Dijkstra’s, with a priority queue.
 
 How to represent a heap:
  Trees hold nodes that store references to their children. In the case of a binary tree,
   these are references to a left and right child.
  Heaps are indeed binary trees, but they can be represented with a simple array
  To represent the heap above as an array,
   you would simply iterate through each element level-by-level from left to right.
  Instead of traversing down the left or right branch like a normal array,
   you can simply access the node in your array using simple formulas.
    - The left child of this node can be found at index 2i + 1.
    - The right child of this node can be found at index 2i + 2.
    - Given a child node at index i,
       this child’s parent node can be found at index floor( (i - 1) / 2).
 
 Operations:
 - Removing from a heap:
    A basic remove operation simply removes the root node from the heap.
    A remove operation will remove the maximum value at the root node.
    To do so, you must first swap the root node with the last element in the heap.
    Once you’ve swapped the two elements,
     you can remove the last element and store its value so you can later return it.
    Since the heap no longer follows this rule, you must perform a sift down.
    To perform a sift down, you start from the current value 3 and check its left and right child.
    If one of the children has a value that is greater than the current value,
     you swap it with the parent.
    If both children have a greater value, you swap the parent with the child having the greater value.
 
    Complexity: The overall complexity of remove() is O(log n).
                Swapping elements in an array takes only O(1),
                 while sifting down elements in a heap takes O(log n) time.
 
 - Inserting into a heap:
    First, you add the value to the end of the heap: Now, you must check the max heap’s property.
    Instead of sifting down, you must now sift up since the node
     that you just inserted might have a higher priority than its parents.
    This sifting up works much like sifting down,
     by comparing the current node with its parent and swapping them if needed.
 
    Complexity: The overall compexity of insert(_:) is O(log n).
                Appending an element in an array takes only O(1),
                while sifting up elements in a heap takes O(log n).
 
 - Searching for an element in a heap:
    To find the index of the element that you wish to delete,
      you must perform a search on the heap. Unfortunately,
      heaps are not designed for fast searches.
    With a binary search tree, you can perform a search in O(log n) time,
      but since heaps are built using an array,
      and the node ordering in an array is different, you can’t even perform a binary search.
 
 Key points:
  - Here is a summary of the algorithmic complexity of
     the heap operations that you implemented in this chapter:
  - The heap data structure is good for maintaining the highest- or lowest-priority element.
  - Every time you insert or remove items from the heap,
     you must check to see if it satisfies the rules of the priority.
 */

struct Heap<Element: Equatable> {
  var elements: [Element] = []
  let sort: (Element, Element) -> Bool
  
  var isEmpty: Bool {
    return elements.isEmpty
  }
  
  var count: Int {
    return elements.count
  }
  
  init(sort: @escaping (Element, Element) -> Bool,
          elements: [Element] = []) {
    self.sort = sort
    self.elements = elements
    
    if !elements.isEmpty {
      for i in stride(from: elements.count / 2 - 1, through: 0, by: -1) {
        siftDown(from: i)
      }
    }
  }
  
  func peek() -> Element? {
    return elements.first
  }
  
  func leftChildIndex(ofParentAt index: Int) -> Int {
    return (2 * index) + 1
  }
  
  func rightChildIndex(ofParentAt index: Int) -> Int {
    return (2 * index) + 2
  }
  
  func parentIndex(ofChildAt index: Int) -> Int {
    return (index - 1) / 2
  }
  
  mutating func remove() -> Element? {
    // 1. Check to see if the heap is empty. If it is, return nil.
    guard !isEmpty else {
      return nil
    }
    // 2. Swap the root with the last element in the heap.
    elements.swapAt(0, count - 1)
    defer {
      // 4. The heap may not be a max or min heap anymore,
      //     so you must perform a sift down to make sure it
      siftDown(from: 0)
    }
    // 3. Remove the last element (the maximum or minimum value) and return it.
    return elements.removeLast()
  }
  
  // Removing from an arbitrary index O(log n)
  mutating func remove(at index: Int) -> Element? {
    guard index < elements.count else {
      // Check to see if the index is within the bounds of the array. If not, return nil.
      return nil
    }
    if index == elements.count - 1 {
      // If you’re removing the last element in the heap, you don’t need to do anything special.
      // Simply remove and return the element.
      return elements.removeLast()
    } else {
      // If you’re not removing the last element, first swap the element with the last element.
      elements.swapAt(index, elements.count - 1)
      defer {
        // Finally, perform a sift down and a sift up to adjust the heap.
        siftDown(from: index)
        siftUp(from: index)
      }
      // Then, return and remove the last element.
      return elements.removeLast()
    }
  }
  
  mutating func siftDown(from index: Int) {
    // Store the parent index.
    var parent = index
    // Continue sifting until you return.
    while true {
      // Get the parent’s left and right child index.
      let left = leftChildIndex(ofParentAt: parent)
      let right = rightChildIndex(ofParentAt: parent)
      // The candidate variable is used to keep track of which index to swap with the parent.
      var candidate = parent
      if left < count && sort(elements[left], elements[candidate]) {
        // If there is a left child,
        //  and it has a higher priority than its parent, make it the candidate.
        candidate = left
      }
      if right < count && sort(elements[right], elements[candidate]) {
        // If there is a right child, and it has an even greater priority,
        //  it will become the candidate instead.
        candidate = right
      }
      if candidate == parent {
        // If candidate is still parent, you have reached the end, and no more sifting is required.
        return
      }
      // Swap candidate with parent and set it as the new parent to continue sifting.
      elements.swapAt(parent, candidate)
      parent = candidate
    }
  }
  
  // insert appends the element to the array and then performs a sift up.
  mutating func insert(_ element: Element) {
    elements.append(element)
    siftUp(from: elements.count - 1)
  }
  
  // siftUp swaps the current node with its parent,
  //  as long as that node has a higher priority than its parent.
  mutating func siftUp(from index: Int) {
    var child = index
    var parent = parentIndex(ofChildAt: child)
    while child > 0 && sort(elements[child], elements[parent]) {
      elements.swapAt(child, parent)
      child = parent
      parent = parentIndex(ofChildAt: child)
    }
  }
  
  func index(of element: Element, startingAt i: Int) -> Int? {
    if i >= count {
      // If the index is greater than or equal to the number of elements in the array,
      //  the search failed. Return nil.
      return nil
    }
    if sort(element, elements[i]) {
      // Check to see if the element that you are looking for has higher priority
      //  than the current element at index i.
      // If it does, the element you are looking for cannot possibly be lower in the heap.
      return nil
    }
    if element == elements[i] {
      // If the element is equal to the element at index i, return i.
      return i
    }
    if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
      // Recursively search for the element starting from the left child of i.
      return j
    }
    if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
      // Recursively search for the element starting from the right child of i.
      return j
    }
    // If both searches failed, the search failed. Return nil.
    return nil
  }
}

var heap = Heap(sort: >, elements: [1,12,3,4,1,6,8,7])

while !heap.isEmpty {
  print(heap.remove()!)
}
