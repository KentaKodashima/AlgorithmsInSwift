// Copyright (c) 2018 Razeware LLC
// For full license & permission details, see LICENSE.markdown.

/*
 Trees:
  The tree is a data structure of profound importance.
 
 Use cases:
  - Representing hierarchical relationships.
  - Managing sorted data.
  - Facilitating fast lookup operations.
 
 Terminology:
  - Node:
     Each node encapsulates some data and keeps track of its children.
  - Parent:
     Every node (except for the topmost one) is connected to exactly one node above it.
     That node is called a parent node.
  - Child:
     The nodes directly below and connected to it are called its child nodes.
     In a tree, every child has exactly one parent. That’s what makes a tree, well, a tree.
  - Root:
     The topmost node in the tree is called the root of the tree.
     It is the only node that has no parent.
  - Leaf:
     A node is a leaf if it has no children.
 
 Traversal algorithms:
  - Depth-first traversal
 
 Key Points:
  - Trees share some similarities to linked lists, but,
     whereas linked-list nodes may only link to one other node,
      a tree node can link to infinitely many nodes.
  - Be comfortable with the tree terminology such as parent, child, leaf and root.
     Many of these terms are common tongue for fellow programmers
      and will be used to help explain other tree structures.
  - Traversals, such as depth-first and level-order traversals, aren't specific to the general tree.
     They work on other trees as well, although their implementation
      will be slightly different based on how the tree is structured.
 */

example(of: "creating a tree") {
  let beverages = TreeNode("Beverages")

  let hot = TreeNode("Hot")
  let cold = TreeNode("Cold")

  beverages.add(hot)
  beverages.add(cold)
}

func makeBeverageTree() -> TreeNode<String> {
  let tree = TreeNode("Beverages")
  
  let hot = TreeNode("hot")
  let cold = TreeNode("cold")
  
  let tea = TreeNode("tea")
  let coffee = TreeNode("coffee")
  let chocolate = TreeNode("cocoa")
  
  let blackTea = TreeNode("black")
  let greenTea = TreeNode("green")
  let chaiTea = TreeNode("chai")
  
  let soda = TreeNode("soda")
  let milk = TreeNode("milk")
  
  let gingerAle = TreeNode("ginger ale")
  let bitterLemon = TreeNode("bitter lemon")
  
  tree.add(hot)
  tree.add(cold)
  
  hot.add(tea)
  hot.add(coffee)
  hot.add(chocolate)
  
  cold.add(soda)
  cold.add(milk)
  
  tea.add(blackTea)
  tea.add(greenTea)
  tea.add(chaiTea)
  
  soda.add(gingerAle)
  soda.add(bitterLemon)
  
  return tree
}

// This produces the following depth-first output
example(of: "depth-first traversal") {
  let tree = makeBeverageTree()
  tree.forEachDepthFirst { print($0.value) }
}

example(of: "level-order traversal") {
  let tree = makeBeverageTree()
  tree.forEachLevelOrder { print($0.value) }
}

example(of: "searching for a node") {
  // tree from last example
  let tree = makeBeverageTree()
  
  if let searchResult1 = tree.search("ginger ale") {
    print("Found node: \(searchResult1.value)")
  }
  
  if let searchResult2 = tree.search("WKD Blue") {
    print(searchResult2.value)
  } else {
    print("Couldn't find WKD Blue")
  }
}
