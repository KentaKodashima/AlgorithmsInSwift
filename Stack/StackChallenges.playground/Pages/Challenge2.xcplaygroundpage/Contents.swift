// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.
/*:
 [Previous Challenge](@previous)
 ## Challenge 2
 Check for balanced parentheses. Given a string, check if there are `(` and `)` characters, and return `true` if the parentheses in the string are balanced.
 ```
 // 1
 h((e))llo(world)() // balanced parentheses
 // 2
 (hello world // unbalanced parentheses
 ```
 */

var testString1 = "h((e))llo(world)()"

/*
 My strategy:
   1. push "(" into stackLeft
   2. push ")" into stackRight
   3. compare the number of elements in each stacks
 
 The answer was...
   1. push "(" into stack
   2. if ")" is found, check if the stack is empty or not.
      if it's not empty, pop the element out
   3. return if the stack is empty or not
 */

// your code here
func checkParentheses(_ string: String) {
  var stackLeft = Stack<Character>()
  var stackRight = Stack<Character>()
  
  for char in string {
    if char == "(" {
      stackLeft.push(char)
    } else if char == ")" {
      stackRight.push(char)
    }
  }
}

// Answer from the book
//func checkParentheses(_ string: String) -> Bool {
//  var stack = Stack<Character>()
//
//  for character in string {
//    if character == "(" {
//      stack.push(character)
//    } else if character == ")" {
//      if stack.isEmpty {
//        return false
//      } else {
//        stack.pop()
//      }
//    }
//  }
//  return stack.isEmpty
//}

 checkParentheses(testString1) // should be true

