//
//  EnumTest.swift
//  FunctionSwiftTest
//
//  Created by ws on 2018/7/26.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import Foundation

enum LookupError: Error {
    case capitalNotFound
    case populationNoteFound
    case mayorNotFound
}

enum PopulationResult {
    case success(Int)
    case error(LookupError)
}

enum Result<T, A> {
    case success(T)
    case error(A)
}

indirect enum BinarySearchTree<Element: Comparable> {
    case leaf
    case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

extension Sequence {
    func all(predicate: (Iterator.Element) -> Bool) -> Bool {
        for x in self where !predicate(x) {
            return false
        }
        return true
    }
}

extension BinarySearchTree {
    init() {
        self = .leaf
    }
    
    init(_ value: Element) {
        self = .node(.leaf, value, .leaf)
    }
    
    var count: Int {
        switch self {
        case .leaf:
            return 0
        case let .node(left, _, right):
            return 1 + left.count + right.count
        }
    }
    
    var elements: [Element] {
        switch self {
        case .leaf:
            return []
        case let .node(left, x, right):
            return [x] + left.elements + right.elements
        }
    }
    
    func reduce<A>(leaf leafF: A, note noteF: (A, Element, A) -> A) -> A {
        switch self {
        case .leaf:
            return leafF
        case let .node(left, x, right):
            return noteF(left.reduce(leaf: leafF, note: noteF), x, right.reduce(leaf: leafF, note: noteF))
        }
    }
    
    var countR:Int {
        return reduce(leaf: 0){1 + $0 + $2}
    }
    
    var elementR: [Element] {
        return reduce(leaf: []){$0 + [$1] + $2}
    }
    
    var isBST: Bool {
        switch self {
        case .leaf:
            return true
        case let .node(left, x, right):
            return left.elements.all{y in y < x}
                && right.elements.all{y in y > x}
                && left.isBST
                && right.isBST
        }
    }
    
    func containts(_ x: Element) -> Bool {
        switch self {
        case .leaf:
            return false
        case let .node(left, y, right):
            return left.containts(x)
                || y == x
                || right.containts(x)
        }
    }
    
    mutating func insert(_ x: Element) {
        switch self {
        case .leaf:
            self = BinarySearchTree(x)
        case .node(var left, let y, var right):
            if x < y { left .insert(x) }
            if x > y { right.insert(x) }
            self = .node(left, x, right)
        }
    }
}

class EnumTest {
    func populationOfCapital(country: String) -> PopulationResult {
        
        let citys: [String: Int] = [:]
        let capitals: [String: String] = [:]
        
        guard let capital = capitals[country] else {
            return .error(.capitalNotFound)
        }
        
        guard let population = citys[capital] else {
            return .error(.populationNoteFound)
        }
        
        return .success(population)
    }
    
    func populationOfCapital2(country: String) -> Result<Int, LookupError> {
        
        let citys: [String: Int] = [:]
        let capitals: [String: String] = [:]
        
        guard let capital = capitals[country] else {
            return .error(.capitalNotFound)
        }
        
        guard let population = citys[capital] else {
            return .error(.populationNoteFound)
        }
        
        return .success(population)
    }
    
    func mayorResult(country: String) -> Result<String, LookupError> {
        
        let mayorReuslt: [String: String] = [:]
        let capitals: [String: String] = [:]
        
        guard let capital = capitals[country] else {
            return .error(.capitalNotFound)
        }
        
        guard let mayor = mayorReuslt[capital] else {
            return .error(.mayorNotFound)
        }
        
        return .success(mayor)
    }
    
    
}
