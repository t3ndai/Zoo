//
//  Exhibit.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/8/17.
//
//

import Foundation
import Vapor
import Fluent


struct Exhibit: Model {
    
    var id: Node?
    var exhibitType: String
    
    init(exhibitType: String) {
        self.exhibitType = exhibitType
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        exhibitType = try node.extract("exhibitType")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "exhibitType": exhibitType
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("exhibits") { exhibits in
            exhibits.id()
            exhibits.string("exhibitType")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("exhibits")
    }
    
    
}
