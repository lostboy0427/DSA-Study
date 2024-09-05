//
//  Stack.swift
//  DSA
//
//  Created by Peide Xiao on 8/31/24.
//

import Foundation


struct Stack<T> {
    var items: [T]
    
   mutating func push(_ item: T) {
        self.items.append(item)
    }
    
   mutating func pop() -> T? {
       if isEmpty() {
           return nil
       } else {
           return self.items.removeLast()
       }
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
