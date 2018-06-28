//
//  ArrayExt.swift
//  FunctionSwiftTest
//
//  Created by ws on 2018/6/27.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import Foundation

extension Array {
    func increment(array: [Int]) -> [Int] {
        var result: [Int] = []
        
        for x in array {
            result.append(x)
        }
        return result
    }
    
    func double(array: [Int]) -> [Int] {
        var result: [Int] = []
        
        for x in array {
            result.append(x * 2)
        }
        return result
    }
    
    func double2(array: [Int]) -> [Int] {
        return compute(array: array){ $0 * 2 }
    }
    
    func compute(array: [Int], transform:(Int) -> Int) -> [Int] {
        var result: [Int] = []
        
        for x in array {
            result.append(transform(x))
        }
        return result
    }
}
