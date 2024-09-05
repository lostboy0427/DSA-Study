//
//  ViewController.swift
//  DSA
//
//  Created by Peide Xiao on 8/31/24.
//

import UIKit

class ViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // LinkList
        
        var list = LinkList<Int>()
        list.push(1)
        list.push(3)
        list.push(5)
        print(list)
        
        list.append(10)
        print(list)
        
        list.insert(201, after: 1)
        list.insert(20, after: 3)
        
        list.append(100)
        print(list)

        list.removeLast()
        print(list)
        
        for i in "Hello world".utf8 {
            print(i, separator: " ")
        }

    }
    
   
}

extension ViewController {
    func linklist() {
       
        
    }
}
