// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*:
 [Previous Challenge](@previous)
 ### Challenge 2
 Write a function that searches a **sorted** array and that finds the range of indices for a particular element. For example:

```swift
let array = [1, 2, 3, 3, 3, 4, 5, 5]
findIndices(of: 3, in: array)
```

`findIndices` should return the range `2..<5`, since those are the start and end indices for the value `3`.
*/
// The time complexity of this solution is O(n), which may not seem to be a cause for concern.
// However, the solution can be optimized to a O(_log n) time complexity solution.
//func findIndices(of value: Int, in array: [Int]) -> Range<Int>? {
//  guard let leftIndex = array.index(of: value) else {
//    return nil
//  }
//  guard let rightIndex = array.reversed().index(of: value) else {
//    return nil
//  }
//  return leftIndex..<rightIndex.base
//}

func findIndices(of value: Int, in array: [Int]) -> CountableRange<Int>? {
  guard let startIndex = startIndex(of: value,
                                    in: array,
                                    range: 0..<array.count) else {
    return nil
  }
  
  guard let endIndex = endIndex(of: value,
                                in: array,
                                range: 0..<array.count) else {
    return nil
  }
  
  return startIndex..<endIndex
}

func startIndex(of value: Int,
                in array: [Int],
                range: CountableRange<Int>) -> Int? {
  // Calculating the middle value of the indices contained in range.
  let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
  
  // This is the base case of this recursive function.
  // If the middle index is the first or last accessible index of the array,
  //  you don’t need to call binary search any further.
  // You’ll make the determination on whether or not
  //  the current index is a valid bound for the given value.
  if middleIndex == 0 || middleIndex == array.count - 1 {
    if array[middleIndex] == value {
      return middleIndex
    } else {
      return nil
    }
  }
  
  // Check the value at the index and make your recursive calls.
  // If the value at middleIndex is equal to the value you’re given,
  //  you check to see if the predecessor is also the same value.
  // If it isn’t, you know that you’ve found the starting bound.
  // Otherwise, you’ll continue by recursively calling startIndex.
  if array[middleIndex] == value {
    if array[middleIndex - 1] != value {
      return middleIndex
    } else {
      return startIndex(of: value,
                        in: array,
                        range: range.lowerBound..<middleIndex)
    }
  } else if value < array[middleIndex]  {
    return startIndex(of: value,
                      in: array,
                      range: range.lowerBound..<middleIndex)
  } else {
    return startIndex(of: value,
                      in: array,
                      range: middleIndex..<range.upperBound)
  }
}

func endIndex(of value: Int,
              in array: [Int],
              range: CountableRange<Int>) -> Int? {
  
  let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
  
  if middleIndex == 0 || middleIndex == array.count - 1 {
    if array[middleIndex] == value {
      return middleIndex + 1
    } else {
      return nil
    }
  }
  
  if array[middleIndex] == value {
    if array[middleIndex + 1] != value {
      return middleIndex + 1
    } else {
      return endIndex(of: value,
                      in: array,
                      range: middleIndex..<range.upperBound)
    }
  } else if value < array[middleIndex]  {
    return endIndex(of: value,
                    in: array,
                    range: range.lowerBound..<middleIndex)
  } else {
    return endIndex(of: value,
                    in: array,
                    range: middleIndex..<range.upperBound)
  }
}

let array = [1, 2, 3, 3, 3, 4, 5, 5]
if let indices = findIndices(of: 3, in: array) {
  indices.forEach { print($0) }
}
