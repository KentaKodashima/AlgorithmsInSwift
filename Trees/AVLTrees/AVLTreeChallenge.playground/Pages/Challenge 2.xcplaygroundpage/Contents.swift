// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 
 ## Challenge 2
 
 How many **nodes** are there in a perfectly balanced tree of height 3? What about a perfectly balanced tree of height `h`?
*/
import Foundation

// Your code here

// In a perfectly balanced tree of height 3, there are 15 nodes.

func nodes(inTreeOfHeight: Int) -> Int {
  var numOfNodes = 0
  var height = inTreeOfHeight
  
  while height != 0 {
    numOfNodes += Int(powf(2.0, Float(height)))
    height -= 1
  }
  
  return numOfNodes + 1
}

// Textbook answer
//func nodes(inTreeOfHeight height: Int) -> Int {
//  var totalHeight = 0
//  for currentHeight in 0...height {
//    totalHeight += Int(pow(2.0, Double(currentHeight)))
//  }
//  return totalHeight
//}

// Faster version
//func nodes(inTreeOfHeight height: Int) -> Int {
//  return Int(pow(2.0, Double(height + 1))) - 1
//}

 nodes(inTreeOfHeight: 3)

//: [Next Challenge](@next)
