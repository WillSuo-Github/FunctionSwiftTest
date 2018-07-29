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

extension BinarySearchTree {
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
