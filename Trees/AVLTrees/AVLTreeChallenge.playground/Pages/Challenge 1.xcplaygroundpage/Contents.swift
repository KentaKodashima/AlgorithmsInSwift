// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 # AVL Tree Challenges
 ## Challenge 1
 How many **leaf** nodes are there in a perfectly balanced tree of height 3? What about a perfectly balanced tree of height `h`?
 */
import Foundation

// Your code here

// In a perfectly balanced tree of height 3, there are 8 leaf nodes.

func leafNodes(inTreeOfHeight: Int) -> Int {
  return Int(powf(2.0, Float(inTreeOfHeight)))
}


// Textbook answer
//func leafNodes(inTreeOfHeight height: Int) -> Int {
//  return Int(pow(2.0, Double(height)))
//}

leafNodes(inTreeOfHeight: 3)

//: [Next Challenge](@next)
