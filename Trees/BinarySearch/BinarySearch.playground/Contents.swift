// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Binary Search:
 Binary search is one of the most efficient
  searching algorithms with a time complexity of O(log n).
 This is comparable with searching for an element inside a balanced binary search tree.
 
 Required conditions:
  - The collection must be able to perform index manipulation in constant time.
    This means that the collection must be a RandomAccessCollection.
  - The collection must be sorted.
 
 Step 1:
 The first step is to find the middle index of the collection.
 This is fairly straightforward:
 
 Step 2: Check the element at the middle index
 The next step is to check the element stored at the middle index.
 If it matches the value you’re looking for, you return the index.
 Otherwise, you’ll continue to Step 3.
 
 Step 3: Recursively call binary Search
 The final step is to recursively call binary search. However,
  this time, you’ll only consider the elements exclusively to the left
  or to the right of the middle index, depending on the value you’re searching for.
 If the value you’re searching for is less than the middle value, you search the left subsequence.
 If it is greater than the middle value, you search the right subsequence.
 
 Key points
  - Binary search is only a valid algorithm on sorted collections.
  - Sometimes, it may be beneficial to sort a collection just to leverage
    the binary search capability for looking up elements.
  - The sort method provided to arrays uses linear search, which has a O(n) time complexity.
    Binary search has a O(log n) time complexity, which scales much better for large data sets.
 */

// Since binary search only works for types that conform to RandomAccessCollection,
//  you add the method in an extension on RandomAccessCollection.
// This extension is constrained as you need to be able to compare elements.
public extension RandomAccessCollection where Element: Comparable {
  
  // Binary search is recursive, so you need to be able to pass in a range to search.
  // The parameter range is made optional
  //  so you can start the search without having to specify a range.
  // In this case, where range is nil, the entire collection will be searched.
  func binarySearch(for value: Element, in range: Range<Index>? = nil) -> Index? {
    // First, you check if range was nil.
    // If so, you create a range that covers the entire collection.
    let range = range ?? startIndex..<endIndex
      
    // Then, you check if the range contains at least one element.
    // If it doesn’t, the search has failed and you return nil.
    guard range.lowerBound < range.upperBound else {
      return nil
    }
      
    // Now that you’re sure you have elements in the range,
    //  you find the middle index in the range.
    let size = distance(from: range.lowerBound, to: range.upperBound)
    let middle = index(range.lowerBound, offsetBy: size / 2)
      
    // You then compare the value at this index with the value that you’re searching for.
    // If they match, you return the middle index.
    if self[middle] == value {
      return middle
      // If not, you recursively search either the left or right half of the collection.
    } else if self[middle] > value {
      return binarySearch(for: value, in: range.lowerBound..<middle)
    } else {
      return binarySearch(for: value, in: index(after: middle)..<range.upperBound)
    }
  }
}

let array = [1, 5, 15, 17, 19, 22, 24, 31, 105, 150]

let search31 = array.index(of: 31)
let binarySearch31 = array.binarySearch(for: 31)

print("index(of:): \(String(describing: search31))")
print("binarySearch(for:): \(String(describing: binarySearch31))")
