//
//  HashTable.swift
//  DSA
//
//  Created by Peide Xiao on 9/5/24.
//

import Foundation

class HashSet {
    var values: [[String]]
    
    init() {
        values = Array(repeating: [String](), count: 10)
    }
    
    func hashFunction(_ key: String) -> Int {
        var total: Int = 0
        for c in key {
            total += Int(String(c).unicodeScalars[String(c).startIndex].value)
        }
        return total % 10
    }
    
    func add(_ item: String) {
        let key = hashFunction(item)
        if !values[key].contains(item) {
            values[key].append(item)
        }
    }
    
    func delete(_ item: String) {
        let key = hashFunction(item)
        values[key].removeAll(where: { $0 == item })
    }
    
}
