//
//  Link.swift
//  DSA
//
//  Created by Peide Xiao on 9/3/24.
//

import Foundation

class Node<Value> {
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
