//
//  Animal.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/7/17.
//
//

import Foundation
import Vapor
import Fluent

struct Animal: Model {
    /**
     Initialize the convertible with a node within a context.
     
     Context is an empty protocol to which any type can conform.
     This allows flexibility. for objects that might require access
     to a context outside of the node ecosystem
     */
   
    
    var id: Node?
    var name: String
    var exhibitId: Int
    var foodType: String
    
    init(name: String, exhibitId: Int, foodType: String){
        self.name = name
        self.exhibitId = exhibitId
        self.foodType = foodType
    }
    

    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        exhibitId = try node.extract("exhibitId")
        foodType = try node.extract("foodType")
    }
    
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
                "id": id,
                "name": name,
                "exhibitId": exhibitId,
                "foodType": foodType
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create("animals") { animals in
            
            animals.id()
            animals.string("name")
            animals.int("exhibitId")
            animals.string("foodType")
            
            
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete("animals")
    }
}
