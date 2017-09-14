//
//  Food.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/8/17.
//
//

import Foundation
import Vapor
import Fluent

struct Food: Model {
    
    var id: Node?
    var foodType: String
    var foodName: String
    var cost: Double
    
    init(foodType: String, foodName: String, cost: Double) {
        
        self.foodName = foodName
        self.foodType = foodType
        self.cost = cost
    }
    
    init(node: Node, in context: Context) throws {
        
        id = try node.extract("id")
        foodType = try node.extract("foodType")
        foodName = try node.extract("foodName")
        cost = try node.extract("cost")
    }
    
    func makeNode(context: Context) throws -> Node {
        
        return try Node(node: [
            "id": id,
            "foodType": foodType,
            "foodName": foodName,
            "cost": cost
            ])
    }
    
    static func prepare(_ database: Database) throws {
        
        try database.create("foods") { foods in
            foods.id()
            foods.string("foodType")
            foods.string("foodName")
            foods.double("cost")
            
        }
    }
    
    static func revert(_ database: Database) throws {
        
        try database.delete("foods")
    }
}
