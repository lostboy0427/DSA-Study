//
//  PriorityQueue.swift
//  DSA
//
//  Created by Peide Xiao on 9/12/24.
//

import Foundation

protocol Queueable {
    associatedtype Element
    mutating func enqueue(_ data: Element) -> Bool
    mutating func dequeue() -> Element?
    var isEmpty: Bool { get }
    var peek: Element? { get }
}

struct PriorityQueue<Element: Equatable>: Queueable {
    var heap: Heap<Element>
    var elements: [Element]
    var sort: (Element, Element) -> Bool
    
    init(elements: [Element] = [], sort: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.sort = sort
        self.heap = Heap(elements: elements, sort: sort)
    }
    
    var isEmpty: Bool {
        heap.isEmpty
    }
    
    var peek: Element? {
        heap.peak()
    }
    
    mutating func enqueue(_ data: Element) -> Bool {
        heap.insert(data)
        return true
    }
    
    mutating func dequeue() -> Element? {
        heap.remove()
    }
    
    
}
