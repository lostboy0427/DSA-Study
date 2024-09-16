//
//  Tree.swift
//  DSA
//
//  Created by Peide Xiao on 9/5/24.
//

import Foundation

class SimpleNode<T>: CustomStringConvertible {
    var data: T
    var children: [SimpleNode] = []
    
    init(_ data: T) {
        self.data = data
    }
    
    var isEmpty: Bool {
        children.isEmpty
    }
    
    func add(_ child: SimpleNode) {
        children.append(child)
    }
    
    func forEachDepthFirst(visit: (SimpleNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
    
    func forEachLevelOrder(visit: (SimpleNode) -> Void) {
        visit(self)
        
        var queue = EfficientQueue<SimpleNode>()
        children.forEach { queue.enqueue($0) }
        
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach{ queue.enqueue($0)}
        }
    }
}

extension SimpleNode where T: Equatable {
    // Search
    func search(_ value: T) -> SimpleNode? {
        var result: SimpleNode?
        forEachLevelOrder { node in
            if node.data == value {
                result = node
            }
        }
        return result
    }
}

extension SimpleNode {
    var description: String {
        return "\(data)"
    }
}



class TreeNode<Value>: CustomStringConvertible {
    var data: Value
    var left: TreeNode<Value>?
    var right: TreeNode<Value>?
    
    init(_ data: Value, _ left: TreeNode<Value>? = nil, _ right: TreeNode<Value>? = nil) {
        self.data = data
        self.left = left
        self.right = right
    }
    // min (simplier way)
    var min: TreeNode? {
        return left?.min ?? self
    }
}

extension TreeNode {
    var description: String {
        return diagram(for: self)
    }
    
    private func diagram(for node: TreeNode?, _ top: String = "", _ root: String = "", _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        
        if node.left == nil && node.right == nil {
            return root + "\(node.data)\n"
        }
        
        return diagram(for: node.right, top + " ", top + "┌──", top + "| ")
        + root + "\(node.data)\n"
        + diagram(for: node.left, bottom + "| ", bottom + "└──", bottom + " ")
    }
}


struct Tree<String> {
    let root: TreeNode<String>
    let binary_tree_array = ["R", "A", "B", "C", "D", "E", "F"]

    init(root: TreeNode<String>) {
        self.root = root
    }
    
    func preOrderTraversal(node: TreeNode<String>?) {
        guard let node = node else { return }
        print(node.data)
        preOrderTraversal(node: node.left)
        preOrderTraversal(node: node.right)
    }
    
    func inOrderTraversal(node: TreeNode<String>?) {
        guard let node = node else { return }
        inOrderTraversal(node: node.left)
        print(node.data)
        inOrderTraversal(node: node.right)
    }
    
    func postOrderTraversal(node: TreeNode<String>?)  {
        guard let node = node else { return }
        postOrderTraversal(node: node.left)
        postOrderTraversal(node: node.right)
        print(node.data)
    }
}

extension Tree { // for Perfect Binary Tree
    func leftChildIndex(_ index: Int) -> Int {
        return 2 * index + 1
    }
    
    func rightChildIndex(_ index: Int) -> Int {
        return 2 * index + 2
    }
    
    func getData(_ index: Int) -> String? {
        if index > 0 && index < binary_tree_array.count {
            return binary_tree_array[index] as? String
        }
        return nil
    }
    
    func pre_order(index: Int) -> [String] {
        if index >= 0 && index < binary_tree_array.count {
            return ([binary_tree_array[0]] as! [String]) + pre_order(index: leftChildIndex(index)) + pre_order(index: rightChildIndex(index))
        }
        return []
    }
    
    func in_order(index: Int) -> [String] {
        if index >= 0 && index < binary_tree_array.count {
            return in_order(index: leftChildIndex(index)) + ([binary_tree_array[0]] as! [String]) + in_order(index: rightChildIndex(index))
        }
        return []
    }
    
    func post_order(index: Int) -> [String] {
        if index >= 0 && index < binary_tree_array.count {
            return post_order(index: leftChildIndex(index)) + post_order(index: rightChildIndex(index)) + ([binary_tree_array[0]] as! [String])
        }
        return []
    }
}



struct BST<T: Comparable> {
    
    var root: TreeNode<T>
    
    init(root: TreeNode<T>) {
        self.root = root
    }
    
    func search(_ node: TreeNode<T>?, _ target: T) -> TreeNode<T>? {
        if node == nil { return nil }
        if node!.data == target {
            return node
        }
            
        if target < node!.data {
            return search(node!.left, target)
        } else {
            return search(node!.right, target)
        }
    }
    
    // insert
    func insert(_ node: TreeNode<T>?, _ num: T) -> TreeNode<T>? {
        if node == nil { return TreeNode(num)}
        
        if num > node!.data {
            node!.right = insert(node!.right, num)
        } else {
            node!.left = insert(node!.left, num)
        }
        return node
    }
    
    // delete
    func delete(_ node: TreeNode<T>?, _ data: T) -> TreeNode<T>? {
        if node == nil { return nil }
        
        if data < node!.data {
            node?.left = delete(node!.left, data)
        } else if data > node!.data {
            node?.right = delete(node!.right, data)
        } else {
            // with only 1 child node or none child
            if node?.left == nil {
                return node?.right
            } else if node?.right == nil {
                return node?.left
            }
            
            // have 2 child nodes
            // delete the in-order successor (smallest in the right subtree)
            let min = lowest(subtree: node?.right)
            node?.data = min.data
            node?.right = delete(node?.right, min.data)
        }
        return node
    }
    
    // find the lowest of a subtree
    func lowest(subtree node: TreeNode<T>?) -> TreeNode<T> {
        var current: TreeNode<T>? = node
        while current?.left != nil {
            current = current!.left
        }
        return current!
    }
}


class AVLNode<T> {
    var data: T
    var left: AVLNode<T>?
    var right: AVLNode<T>?
    var height: Int = 0
    
    init(data: T, left: AVLNode<T>? = nil, right: AVLNode<T>? = nil, height: Int = 1) {
        self.data = data
        self.left = left
        self.right = right
        self.height = height
    }
    
    public var leftHeight: Int {
        left?.height ?? -1
    }
    
    public var rightHeight: Int {
        right?.height ?? -1
    }
    
    public var balanceFactor: Int {
        leftHeight - rightHeight
    }
}

extension AVLNode: CustomStringConvertible {
    var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: AVLNode?, _ top: String = "", _ root: String = "", _ bottom: String = "") -> String {
        guard let node = node else {
            return root + "nil\n"
        }
        
        if node.left == nil && node.right == nil {
            return root + "\(node.data)\n"
        }
        
        return diagram(for: node.right, top + " ", top + "┌──", top + "| ")
        + root + "\(node.data)\n"
        + diagram(for: node.left, bottom + "| ", bottom + "└──", bottom + " ")
    }
}

struct AVLTree<T: Comparable> {
    var root: AVLNode<T>?
     
    // insert
    func insert(_ node: AVLNode<T>?, _ data: T) -> AVLNode<T>? {
        if node == nil { return AVLNode(data: data) }
        if data > node!.data {
            node!.right = insert(node?.right, data)
        } else if (data < node!.data) {
            node!.left = insert(node?.left, data)
        }
        
        node?.height = 1 + max(getHeight(node?.left), getHeight(node?.right))
        let balance = getBalance(node)
        
        if balance > 1 && getBalance(node?.left) >= 0 {
            return rightRotate(node!)
        }
        
        if balance > 1 && getBalance(node?.left) < 0 {
            // left rotate the child node
            node!.left = leftRotate(node!.left!)
            // right rotate the unblanced node
            return rightRotate(node!)
        }
        
        if balance < -1 && getBalance(node?.right) <= 0 {
            return leftRotate(node!)
        }
        
        if balance < -1 && getBalance(node?.right) > 0 {
            node?.right = rightRotate(node!.right!)
            return leftRotate(node!)
        }
       return node
    }
    
    // delete
    
    func delete(_ node: AVLNode<T>?, _ data: T) -> AVLNode<T>? {
        if node == nil { return nil }
        
        if data > node!.data {
            node?.right = delete(node?.right, data)
        } else if data < node!.data {
            node?.left = delete(node?.left, data)
        } else {
            if node?.left == nil {
                return node?.right
            } else if node?.right == nil {
                return node?.left
            }
            
            let min = lowest(subtree: node?.right)
            node?.data = min.data
            node?.right = delete(node?.right, min.data)
        }
        
        if node == nil { return nil }
        // Update the balance factor and balance the tree
        
        node?.height = 1 + max(getHeight(node?.left), getHeight(node?.right))
        let balance = getBalance(node)
        
        if balance > 1 && getBalance(node?.left) >= 0 {
            return rightRotate(node!)
        }
        
        if balance > 1 && getBalance(node?.left) < 0 {
            // left rotate the child node
            node!.left = leftRotate(node!.left!)
            // right rotate the unblanced node
            return rightRotate(node!)
        }
        
        if balance < -1 && getBalance(node?.right) <= 0 {
            return leftRotate(node!)
        }
        
        if balance < -1 && getBalance(node?.right) > 0 {
            node?.right = rightRotate(node!.right!)
            return leftRotate(node!)
        }
        return node
    }
    
    func getHeight(_ node: AVLNode<T>?) -> Int {
        if node == nil { return 0 }
        return node!.height
    }
    
    func getBalance(_ node: AVLNode<T>?) -> Int {
       return getHeight(node?.left) - getHeight(node?.right)
    }
    
    func inOrderTraversal(_ node: AVLNode<T>?) {
        if node == nil { return }
        inOrderTraversal(node?.left)
        print(node!.data)
        inOrderTraversal(node?.right)
    }
    
    // find the lowest of a subtree
    func lowest(subtree node: AVLNode<T>?) -> AVLNode<T> {
        var current: AVLNode<T>? = node
        while current?.left != nil {
            current = current!.left
        }
        return current!
    }
    
    func leftRotate(_ node: AVLNode<T>) -> AVLNode<T>? {
        print("rotate left on node: \(node.data)")
        
        let y = node.right
        let T2 = y?.left
        
        y?.left = node
        node.right = T2
        
        y?.height = 1 + max(getHeight(y?.left), getHeight(y?.right))
        node.height = 1 + max(getHeight(node.left), getHeight(node.right))
        return y
    }
    
    func rightRotate(_ node: AVLNode<T>) -> AVLNode<T>? {
        print("rotate right on node: \(node.data)")
        
        let x = node.left
        let T2 = x?.right
        
        x?.right = node
        node.left = T2
        x?.height = 1 + max(getHeight(x?.left), getHeight(x?.right))
        node.height = 1 + max(getHeight(node.left), getHeight(node.right))
        return x
    }
}
