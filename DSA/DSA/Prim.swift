//
//  Prim.swift
//  DSA
//
//  Created by Peide Xiao on 9/15/24.
//

import Foundation

public struct Prim<T: Hashable> {
    public typealias Graph = AdjacencyList<T>
    public init() {}
    
    //    let graph: Graph
    //    let priorityQueue = PriorityQueue(sort: { $0.weight < $1.weight })
    
    
    
    internal func copyVertices(from graph: Graph, to graph2: Graph) {
        for vertex in graph.vertices {
            _ = graph2.createVertex(vertex.data)
        }
    }
    
    internal func addAvailableEdge(for vertex: Vertex<T>,
                                   in graph: Graph,
                                   check visited: Set<Vertex<T>>,
                                   to priorityQueue: inout PriorityQueue<Edge<T>>) {
        for edge in graph.edges(from: vertex) {
            if !visited.contains(edge.destination) {
                priorityQueue.enqueue(edge)
            }
        }
    }
    
    public func produceMinimumSpanningTree(for graph: Graph) -> (cost: Double, mst: Graph) {
        var cost = 0.0
        let mst = Graph()
        var visited: Set<Vertex<T>> = []
        var priorityQueue = PriorityQueue<Edge<T>>(sort: {
            $0.weight ?? 0.0 < $1.weight ?? 0.0
        })
        
        copyVertices(from: graph, to: mst)
        guard let start = graph.vertices.first else {
            return(cost, mst)
        }
        
        visited.insert(start)
        addAvailableEdge(for: start, in: graph, check: visited, to: &priorityQueue)
        
        while let smallestEdge = priorityQueue.dequeue() {
            let vertex = smallestEdge.destination
            guard !visited.contains(vertex) else {
                continue
            }
            
            visited.insert(vertex)
            cost += smallestEdge.weight ?? 0.0
            
            mst.addUndirectedEdge(between: smallestEdge.source, and: smallestEdge.destination, smallestEdge.weight)
            addAvailableEdge(for: vertex, in: graph, check: visited, to: &priorityQueue)
        }
        
        return (cost, mst)
    }
}
