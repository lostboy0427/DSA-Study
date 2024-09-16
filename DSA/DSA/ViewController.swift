//
//  ViewController.swift
//  DSA
//
//  Created by Peide Xiao on 8/31/24.
//

import UIKit

class ViewController: UIViewController {
    var graph: Graph?
    override func viewDidLoad() {
        super.viewDidLoad()
        heapSort()
    }
}

extension ViewController {
    
    func heapSort() {
        var arr = [170, 45, 75, 90, 802, 24, 2, 66]
        print(DSA.heapSort(&arr))
    }
    
    func prim() {
        var prim = Prim<Int>()
        let graph = AdjacencyList<Int>()
        let v1 = graph.createVertex(1)
        let v2 = graph.createVertex(2)
        let v3 = graph.createVertex(3)
        let v4 = graph.createVertex(4)
        let v5 = graph.createVertex(5)
        let v6 = graph.createVertex(6)
        
        graph.addUndirectedEdge(between: v1, and: v4, 5)
        graph.addUndirectedEdge(between: v1, and: v2, 6)
        graph.addUndirectedEdge(between: v1, and: v3, 1)
        graph.addUndirectedEdge(between: v3, and: v2, 5)
        graph.addUndirectedEdge(between: v3, and: v4, 5)
        graph.addUndirectedEdge(between: v3, and: v5, 6)
        graph.addUndirectedEdge(between: v3, and: v6, 4)
        graph.addUndirectedEdge(between: v2, and: v5, 3)
        graph.addUndirectedEdge(between: v5, and: v6, 6)
        graph.addUndirectedEdge(between: v6, and: v4, 2)
        
        let result: (Double, AdjacencyList<Int>) = prim.produceMinimumSpanningTree(for: graph)
        print(result)
    }
    
    func tries() {
        let trie = Trie<String>()
        trie.insert("cut")
        trie.insert("cute")
        trie.insert("car")
        trie.insert("card")
        trie.insert("current")

        trie.insert("curry")
        trie.insert("cunt")
        
        for collection in trie.collections(startingWith: "cu") {
            print(collection)
        }
    }
    
    func dijkastra() {
        let dungeon = AdjacencyList<String>()
        let entranceRoom = dungeon.createVertex("Entrance")
        let spiderRoom = dungeon.createVertex("Spider")
        let goblinRoom = dungeon.createVertex("Goblin")
        let ratRoom = dungeon.createVertex("Rat")
        let treasureRoom = dungeon.createVertex("Treasure")

        dungeon.addEdge(.directed, from: entranceRoom, to: spiderRoom, 11)
        dungeon.addEdge(.directed, from: spiderRoom, to: goblinRoom, 11)
        dungeon.addEdge(.directed, from: goblinRoom, to: treasureRoom, 11)
        dungeon.addEdge(.directed, from: entranceRoom, to: ratRoom, 31)
        dungeon.addEdge(.directed, from: ratRoom, to: treasureRoom, 12)
        dungeon.addEdge(.directed, from: entranceRoom, to: goblinRoom, 30)

        
        let dijkstra = Dijkstra<String>(graph: dungeon)
        let result = dijkstra.dijkstra(from: entranceRoom, to: goblinRoom)
        
        for path in result! {
            print("\(path.source.data) -> \(path.destination.data)")
        }
    }
    
    func heap() {
        var heap = Heap(elements: [3,2,8,5,0], sort: >)
        print(heap.elements)
        
    }
    
    func simpleTree() {
        //        let treeNode = makeBeverageTree()
        //        treeNode.forEachDepthFirst { print($0) }
        //        treeNode.forEachLevelOrder{ print($0) }
        
        func makeBeverageTree() -> SimpleNode<String> {
            let tree = SimpleNode("Beverages")
            let hot = SimpleNode("hot")
            let cold = SimpleNode("cold")
            let tea = SimpleNode("tea")
            let coffee = SimpleNode("coffee")
            let chocolate = SimpleNode("cocoa")
            let blackTea = SimpleNode("black")
            let greenTea = SimpleNode("green")
            let chaiTea = SimpleNode("chai")
            let soda = SimpleNode("soda")
            let milk = SimpleNode("milk")
            let gingerAle = SimpleNode("ginger ale")
            let bitterLemon = SimpleNode("bitter lemon")
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
    }
    
    func linklist() {
        //  LinkList
        var list = LinkList<Int>()
        list.push(1)
        list.push(3)
        list.push(5)
        print(list)
        
        list.append(10)
        print(list)
        
        list.insert(201, after: 1)
        list.insert(20, after: 3)
        
        list.append(100)
        print(list)
        
        list.removeLast()
        print(list)
    }
    
    func tree() {
        //        let root = TreeNode("R")
        //        let nodeA = TreeNode("A")
        //        let nodeB = TreeNode("B")
        //        let nodeC = TreeNode("C")
        //        let nodeD = TreeNode("D")
        //        let nodeE = TreeNode("E")
        //        let nodeF = TreeNode("F")
        //        let nodeG = TreeNode("G")
        //
        //        root.left = nodeA
        //        root.right = nodeB
        //
        //        nodeA.left = nodeC
        //        nodeA.right = nodeD
        //
        //        nodeB.left = nodeE
        //        nodeB.right = nodeF
        //
        //        nodeF.left = nodeG
        //
        //        print(root)
        //
        //        let tree = Tree(root: root)
        //        tree.postOrderTraversal(node: root)
        //
        //
        //        let root13 = TreeNode(13)
        //        let node7 = TreeNode(7)
        //        let node15 = TreeNode(15)
        //        let node3 = TreeNode(3)
        //        let node8 = TreeNode(8)
        //        let node14 = TreeNode(14)
        //        let node19 = TreeNode(19)
        //        let node18 = TreeNode(18)
        //
        //        let bts = BST(root: root13)
        //        root13.left = node7
        //        root13.right = node15
        //
        //        node7.left = node3
        //        node7.right = node8
        //
        //        node15.left = node14
        //        node15.right = node19
        //
        //        node19.left = node18
        //
        //       print(bts.search(root13, 8))
        //
        
        var root1: AVLNode<String>? = nil
        var tree1 = AVLTree(root: root1)
        
        let letters = ["C","B","E","A","D","H","G","F","P","I","Q"]
        
        for i in letters {
            root1 = tree1.insert(root1, i)
        }
        
        print(root1)
        
        //        tree1.inOrderTraversal(root1)
    }
    
    func graph1() {
        //        let graph = DepthFirstSearch(size: 4)
        //        graph.addVertex("A")
        //        graph.addVertex("B")
        //        graph.addVertex("C")
        //        graph.addVertex("D")
        //
        //        graph.addEdge(0, 1, 3)
        //        graph.addEdge(0, 2, 2)
        //        graph.addEdge(3, 0, 4)
        //        graph.addEdge(2, 1, 1)
        //
        //        graph.printGraph()
        
        let graph = DepthFirstSearch(vertexData: ["A","B","C","D","E","F","G"])
        graph.addEdge(3, 0)
        graph.addEdge(0, 2)
        graph.addEdge(0, 3)
        graph.addEdge(0, 4)
        graph.addEdge(4, 2)
        graph.addEdge(2, 5)
        graph.addEdge(2, 1)
        graph.addEdge(2, 6)
        graph.addEdge(1, 5)
        graph.printGraph()
        graph.dfs_traversal("D")
        
        print(graph.isCycle_uf())
    }
}
