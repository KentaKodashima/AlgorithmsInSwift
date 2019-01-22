import UIKit

/*
 Complexity:
  For algorithms, scalability refers to how the algorithm performs
    in terms of execution time and memory usage as the input size increases.
 
 Big O notation:
  Represent various magnitudes of time complexity.
 
 Time Complexity:
  Time complexity is a measure of the time required to
    run an algorithm as the input size increases.
  - Constant time O(1)
    A constant time algorithm is one that has the same running time
      regardless of the size of the input.
  - Linear Time O(n)
    As the amount of data increases, the running time increases by the same amount.
  - Quadratic time O(n^2)
    This time complexity refers to an algorithm
      that takes time proportional to the square of the input size.
    More commonly referred to as n squared.
  - Logarithmic time O(log n)
    An algorithm that can repeatedly drop half of
      the required comparisons will have logarithmic time complexity.
  - Quasilinear time O(n log n)
    Quasilinear time algorithms perform worse
      than linear time but dramatically better than quadratic time
 
 Space Complexity:
  Space complexity is a measure of the resources required for the algorithm to run.
  To calculate the space complexity, you analyze the memory allocations for the function.
 
 Key Points:
  - Time complexity is a measure on the time required
      to run an algorithm as the input size increases.
  - Space complexity is a measure of the resources required for the algorithm to run.
  - Big O notation is used to represent the general form of time and space complexity.
  - Time and space complexity are high-level measures of scalability;
      they do not measure the actual speed of the algorithm itself.
  - For small data sets, time complexity is usually irrelevant.
    A quasilinear algorithm can be slower than a linear algorithm.
 */

// Constant Time O(1)
// The size of the names array has no effect on the running time of this function.
func checkFirst(names: [String]) {
  if let first = names.first {
    print(first)
  } else {
    print("no names")
  }
}

// Linear Time O(n)
// As the input array increases in size,
//  the number of iterations that the for loop makes is increased by the same amount.
func printNames(names: [String]) {
  for name in names {
    print(name)
  }
}

// Quadratic time O(n^2)
// If you have an array with 10 pieces of data,
//  it will print the full list of 10 names 10 times which means 100 print statements.
// If you increase the input size by one,
//  it will print the full list of 11 names 11 times, resulting in 121 print statements.
func printNames2(names: [String]) {
  for _ in names {
    for name in names {
      print(name)
    }
  }
}

// Logarithmic time O(log n)
// If you were checking if the number 451 existed in the array,
//  the naive algorithm would have to iterate from the beginning to end,
//  making a total of nine inspections for the nine values in the array.
let numbers = [1, 3, 56, 66, 68, 80, 99, 105, 450]

func naiveContains(_ value: Int, in array: [Int]) -> Bool {
  for element in array {
    if element == value {
      return true
    }
  }
  
  return false
}
// However, since the array is sorted, you can,
//  right off the bat, drop half of the comparisons necessary by checking the middle value:
func naiveContains2(_ value: Int, in array: [Int]) -> Bool {
  guard !array.isEmpty else { return false }
  let middleIndex = array.count / 2
  
  if value <= array[middleIndex] {
    for index in 0...middleIndex {
      if array[index] == value {
        return true
      }
    }
  } else {
    for index in middleIndex..<array.count {
      if array[index] == value {
        return true
      }
    }
  }
  
  return false
}

// Comparing Time Complexity
// O(n) The code loops 10000 times and returns 50005000.
func sumFromOne(upto n: Int) -> Int {
  var result = 0
  for i in 1...n {
    result += i
  }
  return result
}

sumFromOne(upto: 10000)

// O(n) This will run faster because it calls compiled code in standard library.
func sumFromOne2(upto n: Int) -> Int {
  return (1...n).reduce(0, +)
}
sumFromOne(upto: 10000)

//
func sumFromOne3(upto n: Int) -> Int {
  return (n + 1) * n / 2
}
sumFromOne(upto: 10000)

// Space Complexity
// O(n) Ptinting the sorted copy of an array.
func printSorted(_ array: [Int]) {
  let sorted = array.sorted()
  for element in sorted {
    print(element)
  }
}

// This implementation respects space constraints.
// O(1) Ptinting the sorted copy of an array.
func printSorted2(_ array: [Int]) {
  // Check for the case if the array is empty. If it is, there's nothing to print.
  guard !array.isEmpty else { return }
  
  // currentCount keeps track of the number of print statements made.
  // minValue stores the last printed value.
  var currentCount = 0
  var minValue = Int.min
  
  // The algorithm begins by printing out all values matching the minValue,
  //  and updates the currentCount according to the number of print statements made.
  for value in array {
    if value == minValue {
      print(value)
      currentCount += 1
    }
  }
  
  while currentCount < array.count {
    
    // Using the while loop, the algorithm finds
    //  the lowest value bigger than minValue and stores it in currentValue.
    var currentValue = array.max()!
    
    for value in array {
      if value < currentValue && value > minValue {
        currentValue = value
      }
    }
    
    // The algorithm then prints all values of currentValue
    //  inside the array while updating currentCount.
    var printCount = 0
    for value in array {
      if value == currentValue {
        print(value)
        currentCount += 1
      }
    }
    
    // minValue is set to currentValue so the next iteration
    //  will try to find the next minimum value.
    minValue = currentValue
  }
}
