//
//  Graph.swift
//  DSA
//
//  Created by Peide Xiao on 9/9/24.
//

import Foundation

struct Graph {
    var vertexData = ["A","B","V","D"]
    
    init() {
        let adjacency_matrix = [
            [0, 1, 1, 1],  //Edges for A
            [1, 0, 1, 0],  //Edges for B
            [1, 1, 0, 0],  // Edges for C
            [1, 0, 0, 0]   // Edges for D
        ]
        connection(adjacency_matrix)
        
    }
    
    private func traversal(_ data: [[Int]]) {
        let size = data.count
        print("\nAdjacency matrix:")
        for i in 0..<size {
            for j in 0..<data[i].count {
                print(data[i][j])
            }
        }
    }
    
    func connection(_ data: [[Int]]) {
        let size = data.count
        for i in 0..<size {
            print("\(vertexData[i]) : ")
            for j in 0..<size {
                if data[i][j] > 0 {
                    print(vertexData[j])
                }
            }
        }
    }
}

// Including DFS & BFS
class DepthFirstSearch {
    var vertexData: [String]
    var adjacenctMatrix: [[Int?]]
    var unionFindArray: [Int] = []
    
    init(vertexData: [String]) {
        self.vertexData = vertexData
        self.adjacenctMatrix = Array(repeating: Array(repeating: nil, count: vertexData.count), count: vertexData.count)
    }
    
    var size: Int {
        return vertexData.count
    }
    
    func addEdge(_ row: Int, _ column: Int, _ weight: Int = 1) {
        // directed
        if (row >= 0 && row < size) || (column >= 0 && column < size) {
            adjacenctMatrix[row][column] = weight
            adjacenctMatrix[column][row] = weight
        }
    }
    
    func printGraph() {
        for row in 0..<size {
            print(adjacenctMatrix[row].map({ num in
                if num == nil { return 0 }
                return num!
            }))
            //            for column in 0..<size {
            //                if adjacenctMatrix[row][column] != nil {
            //                    print(vertexData[column])
            //                }
            //            }
        }
    }
}



// Depth First Search
extension DepthFirstSearch {
    func dfs_traversal(_ startVertex: String) {
        print(startVertex)
        var visits: [Bool] = Array(repeating: false, count: size)
        let start_vertex = self.vertexData.firstIndex(of: startVertex)
        dfs(start_vertex!, &visits)
    }
    
    func dfs(_ index: Int ,_ visited: inout [Bool]) {
        visited[index] = true
        
        for i in 0..<size {
            if adjacenctMatrix[index][i] == 1 && !visited[i]{
                print(vertexData[i])
                dfs(i, &visited)
            }
        }
    }
}


// Breadth First Search
extension DepthFirstSearch {
    func bfs_traverssal(_ start: String) {
        var queue: [Int] = []
        var visits: [Bool] = Array(repeating: false, count: size)
        if let index = self.vertexData.firstIndex(of: start) {
            queue.append(index)
            visits[queue[0]] = true
        }
        
        while queue.count > 0 {
            let current = queue.removeFirst()
            print(vertexData[current])
            
            for i in 0..<size {
                if adjacenctMatrix[current][i] == 1 && !visits[i] {
                    queue.append(i)
                    visits[i] = true
                }
            }
        }
    }
}

// Cycle Detetecion with DFS
extension DepthFirstSearch {
    // DFS Cycle detection for undirected
    /*Line 126-130: DFS cycle detection is run on all vertices in the Graph. This is to make sure all vertices are visited in case the Graph is not connected. If a node is already visited, there must be a cycle, and True is returned. If all nodes are visited just ones, which means no cycles are detected, False is returned.
     
     112-118: This is the part of the DFS cycle detection that visits a vertex, and then visits adjacent vertices recursively. A cycle is detected and True is returned if an adjacent vertex has already been visited, and it is not the parent node.
     
     */
    func isCycle_dfs_util_undireced(_ v: Int, _ visited: inout [Bool], _ parent: Int) -> Bool{
        visited[v] = true
        for i in 0..<size {
            if adjacenctMatrix[v][i] == 1 {
                if visited[i] == false {
                    if isCycle_dfs_util_undireced(i, &visited, v) {
                        return true
                    }
                } else if (parent != i) {
                    return true
                }
            }
        }
        return false
    }
    
    func isCycle_dfs_undirected() -> Bool {
        var visits = Array(repeating: false, count: size)
        
        for i in 0..<size {
            if !visits[i] {
                if isCycle_dfs_util_undireced(i, &visits, -1) {
                    return true
                }
            }
        }
        return false
    }
    
    // var recStack = Array(repeating: false, count: size)
    /*  // DFS Cycle detection for directed
     */
    
    func isCycle_dfs_util(_ v: Int, _ visited: inout [Bool], _ stack: inout [Bool]) -> Bool{
        visited[v] = true
        stack[v] = true
        for i in 0..<size {
            if adjacenctMatrix[v][i] == 1 {
                if visited[i] == false {
                    if isCycle_dfs_util(i, &visited, &stack) {
                        return true
                    }
                } else if stack[i] {
                    return true
                }
            }
        }
        stack[v] = false
        return false
    }
    
    func isCycle_dfs() -> Bool {
        var visits = Array(repeating: false, count: size)
        var recStack = Array(repeating: false, count: size)
        
        for i in 0..<size {
            if !visits[i] {
                if isCycle_dfs_util(i, &visits, &recStack) {
                    return true
                }
            }
        }
        return false
    }
}


// Cycle Detection with Union-Find
extension DepthFirstSearch {
    func isCycle_uf() -> Bool {
        for i in 0..<size {
            self.unionFindArray.append(i)
        }
        
        for i in 0..<size {
            for j in i+1..<size {
                if adjacenctMatrix[i][j] != nil {
                    let x = find(i)
                    let y = find(j)
                    if x == y {
                        return true
                    }
                    union(x, y)
                }
            }
        }
        return false
    }
    
    func find(_ index: Int) -> Int {
        if unionFindArray[index] == index {
            return index
        }
        return find(unionFindArray[index])
    }
    
    func union(_ x: Int, _ y: Int) {
        let x_root = find(x)
        let y_root = find(y)
        unionFindArray[x_root] = y_root
    }
}
