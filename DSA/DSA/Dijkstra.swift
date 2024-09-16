//
//  Dijkstra.swift
//  DSA
//
//  Created by Peide Xiao on 9/13/24.
//

import Foundation

public enum Visit<Element: Hashable> {
    case source
    case edge(Edge<Element>)
}

struct Dijkstra<T: Hashable> {
    
    public typealias Graph = AdjacencyList<T>
    let graph: Graph
    
    public init(graph: Graph) {
        self.graph = graph
    }
    
    func dijkstra(from source: Vertex<T>, to destination: Vertex<T>) -> [Edge<T>]? {
        var visits: [Vertex<T>: Visit<T>] = [source: .source]
        var priorityQueue = PriorityQueue<Vertex<T>>(sort: {
            self.distance(to: $0, in: visits) < self.distance(to: $1, in: visits)
        })
        
        _ = priorityQueue.enqueue(source)
        
        while let visitedVertex = priorityQueue.dequeue() {
            if visitedVertex == destination {
                return route(to: destination, in: visits)
            }
            
            let neighbourEdges = graph.edges(from: visitedVertex)
            for edge in neighbourEdges {
                if let weight = edge.weight {
                    
                    /*
                     You tested whether the visits tree already has an entry for the current vertex's neighbour. If there's no entry, you're going to enqueue this vertex.
                     If there is an entry, you test if the distance to the current vertex, plus the weight, would be less than the distance the priority queue is already using to prioritise the neighbour.
                     You created, or overrode, the entry in the visitstree for the neighbour. The tree will now use this entry to prioritise the vertex.
                     You added the neighbour to the priority queue.
                     */
                    
                    if visits[edge.destination] != nil {
                        if distance(to: visitedVertex, in: visits) + weight < distance(to: edge.destination, in: visits) {
                            visits[edge.destination] = .edge(edge)
                           _ = priorityQueue.enqueue(edge.destination)
                        }
                    } else {
                        visits[edge.destination] = .edge(edge)
                       _ = priorityQueue.enqueue(edge.destination)
                    }
                }
            }
        }
        return nil
    }
    
    func route(to destination: Vertex<T>, in visits: [Vertex<T>: Visit<T>]) -> [Edge<T>] {
        var vertex = destination
        var path: [Edge<T>] = []
        
        while let visit = visits[vertex],
              case .edge(let edge) = visit {
            path = [edge] + path
            vertex = edge.source
        }
        return path
    }
    
    func distance(to destination: Vertex<T>, in visits: [Vertex<T>: Visit<T>]) -> Double {
        let path = route(to: destination, in: visits)
        return path.compactMap { $0.weight }.reduce(0.0) { $0 + $1 }
    }
   
}
