//
//  Manager.swift
//  Cortex
//
//  Created by Bruno Garelli on 9/17/17.
//  Copyright © 2017 Bruno Garelli. All rights reserved.
//

import Foundation
fileprivate protocol EntityProt {
    
}
struct Entity<T: Hashable>: Hashable, EntityProt {
    var value: T
    var index: Int = -1
    var tags: [String] = [key.tag.tagAll]
    init(value: T, tags: [String]? = nil) {
        self.value = value
        if let tags = tags {
            self.tags.append(contentsOf: tags)
        }
    }
    static func ==(rhs: Entity<T>, lsh: Entity<T>) -> Bool {
        return rhs.value == lsh.value
    }
    public var hashValue: Int {
        return self.value.hashValue
    }
}
class Manager<T: Hashable> {
    internal var setOfEnts: Set<Entity<T>>
    internal var entities: [Entity<T>]
    internal var tuples: [(name: String, dat: DicSAny)]
    fileprivate var entitiesTags: [String]
    init(data: [T]) {
        self.entities = []
        self.entitiesTags = []
        self.setOfEnts = Set<Entity<T>>()
        self.tuples = [(name: "primera", dat: ["":""]), (name: "segunda", dat: ["":""]), (name: "tercera", dat: ["":""]), (name: "cuarta", dat: ["":""]), (name: "quinta", dat: ["":""])]
        for case let tuple in self.tuples {
            switch (tuple.name, tuple.dat) {
            case (let name, let dat) where name == "primera":
                print(name)
            default: ()
            }
        }
        add(data: data)
    }
    func add(data: [T], tags: [String]? = nil) {
        for obj in data {
            var newEnt = Entity<T>(value: obj)
            if let tags = tags {
                newEnt.tags.append(contentsOf: tags)
            }
            self.entities.append(newEnt)
        }
    }
    func add(tagData: [String: [T]]) {
        for key in tagData.keys {
            if let values = tagData[key] {
                for obj in values {
                    self.entities.append(Entity<T>(value: obj, tags: [key]))
                }
            }
        }
    }
    func remove(tag: String) -> [Entity<T>] {
        let filtered = filter(byTag: tag)
        for obj in filtered {
            if let index = self.entities.index(of: obj) {
                self.entities.remove(at: index)
            }
        }
        return filtered
    }
    func remove(data: [T]) {
        
    }
    fileprivate func indexes(byTag: String) -> [Int] {
        let filtered = entities.filter { (ent) -> Bool in
            return ent.tags.contains(byTag)
        }
        let reduced = filtered.reduce([]) { (res: [Int], entity: Entity<T>) -> [Int] in
            var res = res
            res.append(entity.index)
            return res
        }
        return reduced
    }
    func filter(byTag: String) -> [Entity<T>] {
        let filtered = entities.filter { (ent) -> Bool in
            return ent.tags.contains(byTag)
        }
        return filtered
    }
    func filterValues(byTag: String) -> [T] {
        let filtered = entities.filter { (ent) -> Bool in
            return ent.tags.contains(byTag)
            }
        let reduced = filtered.reduce([]) { (res: [T], entity: Entity<T>) -> [T] in
                var res = res
                res.append(entity.value)
                return res
            }
        return reduced
    }
}
extension Array where Element: EntityProt {
    func getValues() -> [Element] {
        return []
    }
}
extension Set where Element: EntityProt {
    func getValues() -> [Element] {
        return []
    }
}
