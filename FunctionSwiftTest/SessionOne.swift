//
//  SessionOne.swift
//  FunctionSwiftTest
//
//  Created by great Lock on 2018/7/1.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import Foundation
import UIKit

struct City {
    let name: String
    let population: Int
}

extension City {
    func scalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

protocol Arbitrary {
    static func arbitrary() -> Self
}

extension Int: Arbitrary {
    
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
    
    static func arbitrary(in range:CountableRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        return range.lowerBound + (Int.arbitrary() % diff)
    }
}

extension UnicodeScalar: Arbitrary {
    static func arbitrary() -> UnicodeScalar {
        return UnicodeScalar(Int.arbitrary(in: 65..<90))!
    }
}

extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = Int.arbitrary(in: 0..<40)
        let randomScalars = (0..<randomLength).map { _ in
            UnicodeScalar.arbitrary()
        }
        return String(UnicodeScalarView(randomScalars))
    }
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
}

extension CGSize: Arbitrary {
    static func arbitrary() -> CGSize {
        return CGSize(width: .arbitrary(), height: .arbitrary())
    }
}

class SessionOne {
    init() {
        
        testCheck()
    }
    
    func testCity() {
        let paris = City(name: "Paris", population: 2241)
        let madrid = City(name: "Madrid", population: 3165)
        let amsterdam = City(name: "Amsterdam", population: 827)
        let belin = City(name: "Berlin", population: 3562)
        
        let cities = [paris, madrid, amsterdam, belin]
        
        let final = cities.filter{$0.population > 1000}
            .map{$0.scalingPopulation()}
            .reduce("City: population"){result, c in
                return result + "\n" + "\(c.name): \(c.population)"
        }
        
        print(final)
    }
    
    func testCheck() {
        check1("Area should be at least 0"){(size: CGSize) in size.area >= 0}
    }
    
    func check1<A: Arbitrary>(_ message: String, _ property:(A) -> Bool) -> () {
        for _ in 0..<10000 {
            let value = A.arbitrary()
            guard property(value) else {
                print("\"\(message)\"doesn't hold:\(value)")
                return
            }
        }
        print("\"\(message)\" passed 10000 test")
    }
    
    func pluslsCommutative(x: Int, y: Int) -> Bool {
        return x + y == y + x;
    }
}
