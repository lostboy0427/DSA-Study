//
//  Sort.swift
//  DSA
//
//  Created by Peide Xiao on 9/3/24.
//

import Foundation

var arr1 = [7, 12, 9, 11, 3]
var arr2 = [7, 3, 9, 11, 12]
var arr3 = [10, 0, 8 , 7, 6, 5, 4, 1, 9]
var arr4 = [10, 0, 8 , 7, 6, 5, 4, 9, 3, 2, 1]
var arr5 = [ 2, 3, 0, 2, 3, 2, 3, 0, 3, 1, 0]
var arr6 = [3, 6, 2, 8, 5, 1, 19, 4, 7]
var arr7 = [170, 45, 75, 90, 802, 24, 2, 66]
var arr8 = [ 2, 3, 7, 7, 11, 15, 25]


//        shellSort(&arr3)
//        print(arr4)
//        mergeSort(&arr4, 0, arr4.count - 1)
//        print(bucketSort(arr6))

//        radixSortImprove(&arr7)
//        print("Sorted array: \(arr7)")

//        var numbers = [8, 7, 2, 1, 0]
//        print("Original Array: \(numbers)")
//        quickSort(&numbers, low: 0, high: numbers.count - 1)
//        print("Sorted Array: \(numbers)")

//        print(binarySearch(11, from: arr8))

func bubbleSort(_ arr: inout [Int]) {
    print(arr)
    for i in 0..<arr.count - 1 {
        var isSwapped: Bool = false
        for j in 0..<arr.count - 1 - i {
            var temp: Int
            if arr[j] > arr[j+1] {
                temp = arr[j]
                arr[j] = arr[j+1]
                arr[j+1] = temp
                isSwapped = true
            }
        }
        
        if !isSwapped {
            break
        }
        print(arr)
    }
}

func selectionSort(_ arr: inout [Int]) {
    print(arr)
    for i in 0..<arr.count - 1{
        var isSwapped = false
        var minIndex: Int = i
        for j in i..<arr.count {
            if arr[j] < arr[minIndex] {
                minIndex = j
                isSwapped = true
            }
        }
        
        if !isSwapped {
            break
        }
        
        let value = arr.remove(at: minIndex)
        arr.insert(value, at: i)
        print(arr)
    }
}

func selectionSortImprovement(_ arr: inout [Int]) {
    print(arr)
    for i in 0..<arr.count - 1{
        var minIndex: Int = i
        for j in i+1..<arr.count {
            if arr[j] < arr[minIndex] {
                minIndex = j
            }
        }
        arr.swapAt(i, minIndex)
        print(arr)
    }
}
// [17, 12, 4, 3, 2, 1]
func insertionSort(_ arr: inout [Int]) {
    for i in 1..<arr.count {
        var insertIndex = i
        let currentValue = arr[i]
        //            var j = i - 1
        //            while j >= 0 && arr[j] > currentValue {
        //                arr[j+1] = arr[j]
        //                insertIndex = j
        //                j -= 1
        //            }
        
        for j in (0...i-1).reversed() {
            if arr[j] > currentValue {
                arr[j+1] = arr[j]
                insertIndex = j
            }
        }
        
        arr[insertIndex] = currentValue
        print(arr)
    }
}

// Shell sort
func shellSort(_ arr: inout [Int]) {
    print(arr)
    var gap = arr.count
    while gap > 1 {
        gap = gap/3 + 1
        print("gap: \(gap)")
        for _ in 0..<gap {
            for j in stride(from: 0, to: arr.count - gap, by: gap) {
                print("==j\(j)")
                let key = arr[j + gap]
                var end = j
                
                while (end >= 0 && arr[end] > key) {
                    arr[end + gap] = arr[end]
                    end -= gap
                }
                arr[end+gap] = key
            }
        }
        print(arr)
    }
}

func mergeSort(_ arr: inout [Int], _ start: Int, _ end: Int) {
    if start<end {
        let mid = (start + end)/2
        mergeSort(&arr, start, mid)
        mergeSort(&arr, mid+1, end)
        mergeSort(&arr, start, mid, end)
    }
}

fileprivate func mergeSort(_ arr: inout [Int], _ start: Int, _ mid: Int, _ end: Int) {
    print("\(start)====\(mid)====\(end)")
    let n1 = mid - start + 1
    let n2 = end - mid
    
    var left = Array(repeating: 0, count: n1)
    var right = Array(repeating: 0, count: n2)
    
    for i in 0..<n1 {
        left[i] = arr[start + i]
    }
    
    for j in 0..<n2 {
        right[j] = arr[mid+1+j]
    }
    
    var i: Int = 0, j: Int = 0
    var k = start
    
    while(i < n1 && j < n2) {
        if (left[i] <= right[j]) {
            arr[k] = left[i]
            i += 1
        } else {
            arr[k] = right[j]
            j += 1
        }
        k += 1
    }
    
    while (i < n1) {
        arr[k] = left[i]
        i += 1
        k += 1
    }
    
    while (j < n2) {
        arr[k] = right[j]
        j += 1
        k += 1
    }
    print(arr)
}

func countingSort(_ arr: [Int]) -> [Int] {
    var results = [Int]()
    var dic: [Int: Int] = [:]
    
    for i in 0..<arr.count {
        dic[arr[i]] = 0
    }
    
    for i in 0..<arr.count {
        dic[arr[i]]! += 1
    }
    
    for key in dic.keys.sorted() {
        results.append(contentsOf: Array(repeating: key, count: dic[key]!))
    }
    return results
}

// bucket sort
func bucketSort(_ arr: [Int]) -> [Int] {
    guard let max = arr.max() else { return [] }
    var buckets = Array(repeating: [Int](), count: max+1)
    
    for i in arr {
        buckets[i].append(i)
    }
    
    var results: [Int] = []
    for bucket in buckets {
        results += bucket
    }
    return results
}

// Radix sort
func countingSort(_ array: inout [Int], exp: Int) {
    let n = array.count
    var output = Array(repeating: 0, count: n)
    var count = Array(repeating: 0, count: 10)
    
    for i in 0..<n {
        let index = (array[i] / exp) % 10
        count[index] += 1
    }
    
    for i in 1..<10 {
        count[i] += count[i - 1]
    }
    
    for i in stride(from: n - 1, through: 0, by: -1) {
        let index = (array[i] / exp) % 10
        output[count[index] - 1] = array[i]
        count[index] -= 1
    }
    
    for i in 0..<n {
        array[i] = output[i]
    }
    print(array)
}

func radixSort(_ array: inout [Int]) {
    let max = array.max()!
    var exp = 1
    while max / exp > 0 {
        countingSort(&array, exp: exp)
        exp *= 10
    }
}
///////
///
///
func radixSortImprove(_ arr: inout [Int]) {
    let max = arr.max()!
    var exp = 1
    while max / exp > 0 {
        var count = Array(repeating: [Int](), count: 10)
        var result = [Int]()
        
        for i in 0..<arr.count {
            let index = (arr[i] / exp) % 10
            count[index].append(arr[i])
        }
        
        for i in count {
            result += i
        }
        arr = result
        exp *= 10
    }
}

// Quick Sort
/*
 Original Array: [8, 7, 2, 1, 0]
 *****L: 0 H: 4
 [8, 7, 2, 1, 0]
 [8, 7, 2, 1, 0]
 [8, 7, 2, 1, 0]
 [8, 7, 2, 1, 0]
 ==[0, 7, 2, 1, 8]
 *****L: 1 H: 4
 [0, 7, 2, 1, 8]
 [0, 7, 2, 1, 8]
 [0, 7, 2, 1, 8]
 ==[0, 7, 2, 1, 8]
 *****L: 1 H: 3
 [0, 7, 2, 1, 8]
 [0, 7, 2, 1, 8]
 ==[0, 1, 2, 7, 8]
 *****L: 2 H: 3
 [0, 1, 2, 7, 8]
 ==[0, 1, 2, 7, 8]
 Sorted Array: [0, 1, 2, 7, 8]
 */
func quickSort(_ arr: inout [Int], low: Int, high: Int) {
    if low < high {
        print("*****L: \(low) H: \(high)")
        let pivotIndex = partition(&arr, low: low, high: high)
        quickSort(&arr, low: low, high: pivotIndex - 1)
        quickSort(&arr, low: pivotIndex + 1, high: high)
    }
}

func partition(_ arr: inout [Int], low: Int, high: Int) -> Int {
    let pivot = arr[high]
    var i = low
    
    for j in low..<high {
        if arr[j] < pivot {
            arr.swapAt(i, j)
            i += 1
        }
        print(arr)
    }
    arr.swapAt(i, high)
    print("==\(arr)")
    return i
}

func heapSort(_ arr: inout [Int]) -> [Int] {
    
    var count = arr.count
    var results: [Int] = []
    
    var heap = Heap<Int>(elements: arr, sort: <)
  
    while count > 1 {
        heap.elements.swapAt(0, count - 1)
        results.append(heap.elements.removeLast())
        heap.siftDown(elementAtIndex: 0)
        count -= 1
    }
    
    return results
}

