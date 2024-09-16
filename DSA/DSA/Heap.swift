//
//  Heap.swift
//  DSA
//
//  Created by Peide Xiao on 9/12/24.
//

import Foundation

struct Heap<Element: Equatable> {
    var elements: [Element] = []
    let sort: (Element, Element) -> Bool

    
    init(elements: [Element], sort: @escaping (Element, Element) -> Bool) {
        self.elements = elements
        self.sort = sort
        buildHeap()
    }
    
    var isEmpty: Bool {
        elements.isEmpty
    }
    
    var count: Int {
        elements.count
    }
    
    // when elements is not sorted
    mutating func buildHeap() {
        for index in (0..<count/2).reversed() {
            siftDown(elementAtIndex: index)
        }
    }
    
    func peak() -> Element? {
        elements.first
    }
    
    func isRoot(_ index: Int) -> Bool {
        index == 0
    }
    
    func leftChildIndex(ofParentAt index: Int) -> Int {
        2 * index + 1
    }
    
    func rightChildIndex(ofParentAt index: Int) -> Int {
        2 * index + 2
    }
    
    func parentIndex(ofChildAt index: Int) -> Int {
        (index - 1) / 2
    }
    
    func isHigherPriority(at firstIndex: Int, then secondIndex: Int) -> Bool {
        sort(elements[firstIndex], elements[secondIndex])
    }
    
    func highestPriorityIndex(of parentIndex: Int, and childIndex: Int) -> Int {
        guard childIndex < count, isHigherPriority(at: parentIndex, then: childIndex) else {
            return childIndex
        }
        return parentIndex
    }
    
    func highestPriorityIndex(of parentIndex: Int) -> Int {
        highestPriorityIndex(of: highestPriorityIndex(of: parentIndex, and: leftChildIndex(ofParentAt: parentIndex)), and: rightChildIndex(ofParentAt: parentIndex))
    }
    
    // remove the root
    mutating func remove() -> Element? {
        guard !isEmpty else { return nil }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(elementAtIndex: 0)
        }
        return elements.removeLast()
    }
    
    mutating func insert(_ data: Element) {
        elements.append(data)
        siftUp(elementAtIndex: count - 1)
    }
    
    mutating func siftUp(elementAtIndex index: Int) {
         let parent = parentIndex(ofChildAt: index)
        guard !isRoot(index) && isHigherPriority(at: index, then: parent) else { return }
        swapElement(index, parent)
        siftUp(elementAtIndex: parent)
    }
    
    mutating func siftDown(elementAtIndex index: Int) {
        guard index < count / 2 else { return }
        let childIndex = highestPriorityIndex(of: index)
        if index == childIndex {
            return
        }
        swapElement(index, childIndex)
        siftDown(elementAtIndex: childIndex)
    }
    
    
//    mutating private func siftDown(from index: Int) {
//        var parentIndex = index
//        while 2 * parentIndex + 2 < count {
//            let left = leftChildIndex(ofParentAt: parentIndex)
//            let right = rightChildIndex(ofParentAt: parentIndex)
//            
//            if elements[parentIndex] < elements[left] {
//                elements.swapAt(parentIndex, left)
//            }
//                        
//            if elements[parentIndex] < elements[right] {
//                elements.swapAt(parentIndex, right)
//            }
//            parentIndex += 1
//        }
//    }
    
    mutating private func swapElement(_ firstIndex: Int, _ secondIndex: Int) {
        guard firstIndex != secondIndex, firstIndex < count, secondIndex < count else { return }
        elements.swapAt(firstIndex, secondIndex)
    }
    
//    mutating func siftUp(from index: Int) {
//        var i = index
//        while i > 0 && parentIndex(ofChildAt: i) >= 0 {
//            if elements[i] > elements[parentIndex(ofChildAt: i)] {
//                elements.swapAt(i, parentIndex(ofChildAt: i))
//            }
//            i = parentIndex(ofChildAt: i)
//        }
//    }
//    
    mutating func remove(at index: Int) -> Element? {
        if index >= count {
            return nil
        }
        
        if index == count - 1{
            return elements.removeLast()
        }
        
        elements.swapAt(index, count - 1)
        defer {
            siftUp(elementAtIndex: index)
            siftDown(elementAtIndex: index)
        }
        return elements.removeLast()
    }
    
//    func index(of element: Element, startingAt i: Int) -> Int? {
//        if i >= count { return nil }
//        if element > elements.first! { return nil }
//        
//        if element == elements[i] { return i }
//        
//        if let j = index(of: element, startingAt: leftChildIndex(ofParentAt: i)) {
//            return j
//        }
//        
//        if let j = index(of: element, startingAt: rightChildIndex(ofParentAt: i)) {
//            return j
//        }
//        return nil
//    }
}
