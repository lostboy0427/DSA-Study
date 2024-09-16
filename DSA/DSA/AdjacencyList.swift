//
//  AdjacencyList.swift
//  DSA
//
//  Created by Peide Xiao on 9/10/24.
//

import Foundation

public struct Vertex<T> {
    var index: Int
    var data: T
}

extension Vertex: Hashable {
    public static func == (lhs: Vertex<T>, rhs: Vertex<T>) -> Bool {
        return lhs.index == rhs.index
    }
    
    public var hashValue: Int {
        index.hashValue
    }
}

public struct Edge<T>: Equatable {
    var source: Vertex<T>
    var destination: Vertex<T>
    var weight: Double?
    var type: EdgeType = .undirected
}

enum EdgeType {
    case directed, undirected
}


protocol Graphable {
    associatedtype Element
    mutating func createVertex(_ data: Element) -> Vertex<Element>
    mutating func addDirectedEdge(from source: Vertex<Element>, to destination: Vertex<Element>, _ weight: Double?, _ type: EdgeType)
    mutating func addUndirectedEdge(between source: Vertex<Element>, and destination: Vertex<Element>, _ weight: Double?)
    func edges(from source: Vertex<Element>) -> [Edge<Element>]
    func weight(from source: Vertex<Element>, to destination: Vertex<Element>) -> Double?
}

public class AdjacencyList<T>: Graphable {
    private var adjacencies: [Vertex<T>: [Edge<T>]] = [:]
    public var vertices: [Vertex<T>] {
        return Array(adjacencies.keys)
    }
    
    public init() {}
    
    func createVertex(_ data: T) -> Vertex<T> {
        let vertex = Vertex(index: adjacencies.count, data: data)
        adjacencies[vertex] = []
        return vertex
    }
    
    func addEdge(_ type: EdgeType, from source: Vertex<T>, to destination: Vertex<T>, _ weight: Double?) {
        switch type {
        case .directed:
            addDirectedEdge(from: source, to: destination, weight)
        case .undirected:
            addUndirectedEdge(between: source, and: destination, weight)
        }
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, _ weight: Double?, _ type: EdgeType = .undirected) {
        let edge = Edge(source: source, destination: destination, weight: weight, type: .directed)
        adjacencies[source]?.append(edge)
    }
    
    func addUndirectedEdge(between source: Vertex<T>, and destination: Vertex<T>, _ weight: Double?) {
        addDirectedEdge(from: source, to: destination, weight)
        addDirectedEdge(from: destination, to: source, weight)
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        adjacencies[source] ?? []
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        adjacencies[source]!.filter { $0.destination == destination }.first?.weight
    }
    
}

class AdjacencyMatrix<T> {
    var vertices: [Vertex<T>] = []
    var weightMatrix: [[Double?]] = []
    
    public init() {}
}

extension AdjacencyMatrix: Graphable {
    
    func createVertex(_ data: T) -> Vertex<T> {
        let vertex = Vertex(index: vertices.count, data: data)
        vertices.append(vertex)
        
        for i in 0..<weightMatrix.count {
            weightMatrix[i].append(nil)
        }
        
        let row = [Double?](repeating: nil, count: vertices.count)
        weightMatrix.append(row)
        
        return vertex
    }
    
    func addDirectedEdge(from source: Vertex<T>, to destination: Vertex<T>, _ weight: Double?, _ type: EdgeType) {
        weightMatrix[source.index][destination.index] = weight ?? 0
    }
    
    func addUndirectedEdge(between source: Vertex<T>, and destination: Vertex<T>, _ weight: Double?) {
        weightMatrix[source.index][destination.index] = weight ?? 0
        weightMatrix[destination.index][source.index] = weight ?? 0
    }
    
    func edges(from source: Vertex<T>) -> [Edge<T>] {
        var result: [Edge<T>] = []
        for(index, value) in weightMatrix[source.index].enumerated() {
            let destination = vertices[index]
            result.append(Edge(source: source, destination: destination, weight: value))
        }
        return result
    }
    
    func weight(from source: Vertex<T>, to destination: Vertex<T>) -> Double? {
        weightMatrix[source.index][destination.index]
    }
    
}
