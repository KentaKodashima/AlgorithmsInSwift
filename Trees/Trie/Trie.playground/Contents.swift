// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Trie:
 The trie (pronounced as try) is a tree that specializes
  in storing data that can be represented as a collection, such as English words.
 Each character in a string is mapped to a node.
 The last node in each string is marked as a terminating node.
 
 Key points
  - Tries provide great performance metrics in regards to prefix matching.
  - Tries are relatively memory efficient since individual nodes
     can be shared between many different values.
    For example, "car," "carbs," and "care" can share the first three letters of the word.
 */

// words(matching:) will go through the collection of
//  strings and return the strings that match the prefix.
// If you’re dealing with more than a few thousand words,
//  the time it takes to go through the words array will be unacceptable.
// The time complexity of words(matching:) is O(k*n),
//  where k is the longest string in the collection,
//  and n is the number of words you need to check.
//class EnglishDictionary {
//
//  private var words: [String]
//
//  func words(matching prefix: String) -> [String] {
//    return words.filter { $0.hasPrefix(prefix) }
//  }
//}

// Trie can be much more efficient in this case.
// Using tree, all you have to do is just to search each letter one by one.

example(of: "insert and contains") {
  let trie = Trie<String>()
  trie.insert("cute")
  if trie.contains("cute") {
    print("cute is in the trie")
  }
}

example(of: "remove") {
  let trie = Trie<String>()
  trie.insert("cut")
  trie.insert("cute")

  print("\n*** Before removing ***")
  assert(trie.contains("cut"))
  print("\"cut\" is in the trie")
  assert(trie.contains("cute"))
  print("\"cute\" is in the trie")

  print("\n*** After removing cut ***")
  trie.remove("cut")
  assert(!trie.contains("cut"))
  assert(trie.contains("cute"))
  print("\"cute\" is still in the trie")
}

example(of: "prefix matching") {
  let trie = Trie<String>()
  trie.insert("car")
  trie.insert("card")
  trie.insert("care")
  trie.insert("cared")
  trie.insert("cars")
  trie.insert("carbs")
  trie.insert("carapace")
  trie.insert("cargo")

  print("\nCollections starting with \"car\"")
  let prefixedWithCar = trie.collections(startingWith: "car")
  print(prefixedWithCar)

  print("\nCollections starting with \"care\"")
  let prefixedWithCare = trie.collections(startingWith: "care")
  print(prefixedWithCare)
}
