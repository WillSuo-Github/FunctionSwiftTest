//
//  ShipRegion.swift
//  FunctionSwiftTest
//
//  Created by great Lock on 2018/6/24.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import UIKit

typealias Distance = Double
typealias Region = (Position) -> Bool

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
    
    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    
    var length: Double {
        return sqrt(x * x + y * y)
    }
    
    func circle(radius: Distance) -> Region {
        return {point in point.length <= radius}
    }
    
    func shift(_ region: @escaping Region, by offset: Position) -> Region {
        return {point in region(point.minus(offset))}
    }
    
    func intersect(region: @escaping Region, otherRegion: @escaping Region) -> Region {
        return {point in region(point) && otherRegion(point)}
    }
    
    func invert(region: @escaping Region) -> Region {
        return {point in !region(point)}
    }
    
//    func subtract(region: @escaping Region, from original: @escaping Region) -> Region {
//        return {point in self.intersect(region: region, otherRegion: self.invert(region: original))}
//    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canSafeEngage(ship target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange && firingRange > unsafeRange && (friendlyDistance > unsafeRange)
    }
}


class ShipRegion: NSObject {
    
    override init() {
        super.init()
        let inter = intersect(region: shift2(region: circle(radius: 5), by: Position(x: 5, y: 5)), otherRegion: circle(radius: 5))
        
        print(inter(Position(x: 1, y: 1)))
    }

    func intersect(region: @escaping Region, otherRegion: @escaping Region) -> Region {
        return {point in region(point) && otherRegion(point)}
    }
    
    func invert(region: @escaping Region, by offset: Position) -> Region {
        return {point in !region(point.minus(offset))}
    }
    
    func shift2(region: @escaping Region, by offset: Position) -> Region {
        return {point in region(point.minus(offset))}
    }
    
    func shift(radius: Distance, by offset: Position) -> Region {
        return {point in self.circle(radius: radius)(point.minus(offset))}
    }
    
    func circle(radius: Distance) -> Region {
        return {point in point.length <= radius}
    }
}


