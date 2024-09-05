//
//  Queue.swift
//  DSA
//
//  Created by Peide Xiao on 8/31/24.
//

import Foundation

struct Queue<T> {
    var items: [T]
    
    mutating func enqueue(_ item: T) {
        self.items.append(item)
    }
    
    mutating func dequeue() -> T? {
        if isEmpty() {
            return nil
        } else {
            return self.items.removeFirst()
        }
    }
    
    func peak() -> T? {
        self.items.first
    }
    
    func isEmpty() -> Bool {
        items.isEmpty
    }
    
    func size() -> Int {
        items.count
    }
    
    subscript(_ i: Int) -> T {
        items[i]
    }
}


struct EfficientQueue<T> {
    var items = [T?]()
    var head = 0
    
    mutating func enqueue(_ item: T) {
        self.items.append(item)
    }
    
    mutating func dequeue() -> T? {
        guard head < items.count, let element = items[head] else { return nil }
        items[head] = nil
        head += 1
        
        
        if size > 50 && Double(head)/Double(items.count) > 0.25 {
            items.removeFirst(head)
            head = 0
        }
        return element
    }
    
    func peak() -> T? {
        self.items[head]
    }
    
    var isEmpty: Bool {
       return size <= 0
    }
    
    var size: Int {
        items.count - head
    }
    
    subscript(_ i: Int) -> T? {
        items[i]
    }
}
