//
//  Search.swift
//  DSA
//
//  Created by Peide Xiao on 9/3/24.
//

import Foundation

func binarySearch(_ num: Int ,from arr: [Int]) -> Int? {
    var left = 0
    var right = arr.count - 1
    
    while left <= right {
        let mid = (left+right)/2
        if arr[mid] == num {
            return mid
        }
        
        if arr[mid] < num {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return -1
}

func linearSearch(_ num: Int, from arr: [Int]) -> Int? {
    return arr.firstIndex(of: num)
}
