//
//  FoodController.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/22/17.
//
//

import Foundation
import Vapor
import HTTP

struct FoodController: ResourceRepresentable {
    
    func index(_ request: Request) throws -> ResponseRepresentable {
        
        return try Food.all().makeNode().converted(to: JSON.self)
    }
    
    func create(_ request: Request) throws -> ResponseRepresentable {
        
        guard let foodName = request.data["foodName"]?.string else { throw Abort.badRequest }
        guard let foodType = request.data["foodType"]?.string else { throw Abort.badRequest }
        guard let cost = request.data["cost"]?.double else { throw Abort.badRequest }
        
        var food = Food(foodType: foodType, foodName: foodName, cost: cost)
        try food.save()
        
        return try JSON(node: [
                "food": food.id
            ])
    }
    
    
    func delete(_ request: Request, food: Food) throws -> ResponseRepresentable {
        
        try food.delete()
        return JSON([:])
    }
    
    func makeResource() -> Resource<Food> {
        
        return Resource(
            index: index,
            store: create,
            destroy: delete
        )
    }
    
}
