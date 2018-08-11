//
//  StringTree.swift
//  FunctionSwiftTest
//
//  Created by ws on 2018/8/6.
//  Copyright © 2018年 great Lock baidu. All rights reserved.
//

import Foundation

extension ArraySlice {
    var decomposed: (Element, ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex], self.dropFirst())
    }
}

extension Array {
    var slice: ArraySlice<Element> {
        return ArraySlice(self)
    }
    
}

extension String {
    func complete(_ knownWords: Trie<Character>) -> [String] {
        let chars = Array(self).slice
        let completed = knownWords.complete(key: chars)
        return completed.map{ chars in
            self + String(chars)
        }
    }
}

struct Trie<Element: Hashable> {
    let isElement: Bool
    let children: [Element: Trie<Element>]
}

extension Trie {
    init() {
        isElement = false
        children = [:]
    }
    
    init(_ key: ArraySlice<Element>) {
        if let (head, tail) = key.decomposed {
            let children = [head: Trie(tail)]
            self = Trie(isElement: false, children: children)
        }else {
            self = Trie(isElement: true, children: [:])
        }
    }
    
    func inserting(_ key: ArraySlice<Element>) -> Trie<Element> {
        guard let (head, tail) = key.decomposed else{
            return Trie(isElement: true, children: children)
        }
        
        var newChildren = children
        if let nextTrie = children[head] {
            newChildren[head] = nextTrie.inserting(tail)
        }else {
            newChildren[head] = Trie(tail)
        }
        
        return Trie(isElement: isElement, children: newChildren)
    }
    
    func complete(key: ArraySlice<Element>) -> [[Element]] {
        return lookUp(key: key)?.elements ?? []
    }
    
    func lookUp(key: ArraySlice<Element>) -> Trie<Element>? {
        guard let (head, tail) = key.decomposed else { return self }
        guard let remainder = children[head] else { return nil }
        return remainder.lookUp(key: tail)
    }
    
    var elements: [[Element]] {
        var result: [[Element]] = isElement ? [[]] : []
        for (key, value) in children {
            result += value.elements.map{ [key] + $0 }
        }
        return result
    }
    
    
    static func bulid(words: [String]) -> Trie<Character> {
        let emptyTrie = Trie<Character>()
        return words.reduce(emptyTrie){ trie, word in
            trie.inserting(Array(word).slice)
        }
    }
}

class StringTree {
    init() {
        let contents = ["cat", "car", "cart", "dog"]
        let trieOfWords = Trie<Character>.bulid(words: contents)
        let result = "ca".complete(trieOfWords)
        print(result)
    }
}
