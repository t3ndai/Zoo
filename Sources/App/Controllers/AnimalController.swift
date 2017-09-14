//
//  AnimalController.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/8/17.
//
//

import Foundation
import Vapor
import HTTP

struct AnimalController: ResourceRepresentable {
    
    func index(request: Request) throws -> ResponseRepresentable {
        
        return try Animal.all().makeNode().converted(to: JSON.self)
    }
    
    func create(request: Request) throws -> ResponseRepresentable {
        
        
        guard let animalName = request.data["animalName"]?.string else { throw Abort.badRequest }
        guard let foodType = request.data["foodType"]?.string else { throw Abort.badRequest }
        guard let exhibitId = request.data["exhibitId"]?.int else {throw Abort.badRequest}
        
        var animal = Animal(name: animalName , exhibitId: exhibitId , foodType: foodType )
        try animal.save()
        return try JSON(node: [
            "animal": animal.id
            ])
        

    }
    
    func delete(request: Request, animal: Animal) throws -> ResponseRepresentable {
        try animal.delete()
        return JSON([:])
    }
    
    
    /*func show(_ request: Request, Animal.self) throws -> ResponseRepresentable {
        
        guard let animalName = request.query?["animalName"]?.string else { throw Abort.custom(status: .preconditionFailed, message: "include animal name") }
        
        let animalQuery = try Animal.query().filter("name", animalName)
        
        return
        
    }*/
    
    
    
    
    
    func makeResource() -> Resource<Animal> {
        /*
         index: index,
         store: create,
         show: show,
         replace: replace,
         modify: update,
         destroy: delete,
         clear: clear
 
        */
        return Resource(
            index: index,
            store: create,
            destroy: delete
            
        )
        
    }
    
}


