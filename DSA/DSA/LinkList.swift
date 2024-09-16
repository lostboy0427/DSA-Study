//
//  Link.swift
//  DSA
//
//  Created by Peide Xiao on 9/3/24.
//

import Foundation

class Node<Value>: Equatable {
    static func == (lhs: Node<Value>, rhs: Node<Value>) -> Bool {
        return lhs.next == rhs.next
    }
    
    var value: Value
    var next: Node?
    
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
    
    
}

extension Node: CustomStringConvertible {
    var description: String {
        if let next = next {
            return "\(value) -> " + String(describing: next)
        }
        return "\(value)"
    }
}


struct LinkList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    
    var isEmpty: Bool {
        head == nil
    }
    
   mutating func push(_ value: Value) {
       head = Node(value: value, next: head)
       if tail == nil {
           tail = head
       }
    }
    
    mutating func append(_ value: Value) {
        if isEmpty {
            push(value)
        } else {
            tail?.next = Node(value: value)
            tail = tail?.next
        }
    }
    
    mutating func insert(_ value: Value, after index: Int) {
        if isEmpty {
            fatalError("list is empty")
        }
        
        var node: Node<Value> = head!
        var temp = 0
        while temp < index {
            node = node.next!
            temp += 1
        }
        
        let new = Node(value: value)
        new.next = node.next
        node.next = new
    }
    
    func node(at index: Int) -> Node<Value>? {
         var currentNode = head
         var currentIndex = 0
         
         while currentNode != nil && currentIndex < index {
           currentNode = currentNode!.next
           currentIndex += 1
         }
         
         return currentNode
    }
    
    // Remove
    
    mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var pre = head
        var current = head
        
        while let next = current.next {
            pre = current
            current = next
        }
        
        pre.next = nil
        tail = pre
        return current.value
    }
    
    mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
      
        return node.next?.value
    }
}

extension LinkList: CustomStringConvertible {
    var description: String {
        if let head = head {
           return String(describing: head)
        }
        return "Empty List"
    }
}

class Node1<Value> {
    var prior: Node1?
    var next: Node1?
    var value: Value
    
    init(prior: Node1? = nil, next: Node1? = nil, value: Value) {
        self.prior = prior
        self.next = next
        self.value = value
    }
}


struct DoubleLinkList<Value> {
    var head: Node1<Value>?
    var tail: Node1<Value>?
    
    init() {}
    
    var isEmpty: Bool {
        head == nil
    }
    
    //  push at the beginning
    mutating func push(_ value: Value) {
        let node = Node1(value: value)
        if isEmpty {
            head = node
            tail = head
        } else {
            head?.prior = node
            head = node
        }
    }
    
    // append at the end
    
    mutating func append(_ value: Value) {
        let node = Node1(value: value)
        if isEmpty {
            push(value)
        } else {
            node.prior = tail
            tail?.next = node
            tail = node
        }
    }
    
    func node(at index: Int) -> Node1<Value>? {
        if isEmpty { return nil }
        
        var currentIndex = 0
        var currentNode: Node1? = head
        
        while currentIndex < index && currentNode != nil {
            currentNode = currentNode?.next
            currentIndex += 1
        }
        return currentNode
    }
    
    func length() -> Int {
        var total = 0
        var currentNode: Node1? = head
        
        while currentNode != nil {
            currentNode = currentNode?.next
            total += 1
        }
        return total
    }
    
    func insert(_ value: Value, after index: Int) {
        let node = Node1(value: value)
        if var prior = self.node(at: index) {
            node.next = prior.next
            prior.next = node
            node.prior = prior
        }
    }
}
