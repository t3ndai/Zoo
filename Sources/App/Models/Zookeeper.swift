//
//  Zookeeper.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/8/17.
//
//

import Foundation
import Vapor
import Fluent

struct Zookeeper: Model {
    
    var id: Node?
    var firstName: String
    var lastName: String
    var exhibitId: String
    
    init(firstName: String, lastName: String, exhibitId: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.exhibitId = exhibitId
    }
    
    init(node: Node, in context: Context) throws {
        
        id = try node.extract("id")
        firstName = try node.extract("firstName")
        lastName = try node.extract("lastName")
        exhibitId = try node.extract("exhibitId")
    }
    
    func makeNode(context: Context) throws -> Node {
        
        return try Node(node: [
            
            "id": id,
            "firstName": firstName,
            "lastName": lastName,
            "exhibitId": exhibitId
            ])
    }
    
    static func prepare(_ database: Database) throws {
        
        try database.create("zookeepers") { zookeepers in
            zookeepers.id()
            zookeepers.string("firstName")
            zookeepers.string("lastName")
            zookeepers.string("exhibitId")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("zookeepers")
    }
    
}
