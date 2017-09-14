//
//  ZooController.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/22/17.
//
//

import Foundation
import Vapor
import HTTP

struct ZooController: ResourceRepresentable {
    
    func index(_ request: Request) throws -> ResponseRepresentable {
        
        return try Zookeeper.all().makeNode().converted(to: JSON.self)
    }
    
    func create(_ request: Request) throws -> ResponseRepresentable {
        
        guard let firstName = request.data["firstName"]?.string else { throw Abort.badRequest }
        guard let lastName = request.data["lastName"]?.string else { throw Abort.badRequest }
        guard let exhibitId = request.data["exhibitId"]?.string else { throw Abort.badRequest }
        
        var zookeeper = Zookeeper(firstName: firstName, lastName: lastName, exhibitId: exhibitId)
        try zookeeper.save()
        
        return try JSON(node: [
                "zookeeper ID": zookeeper.id
            ])

    }
    
    func delete(_ request: Request, zookeeper: Zookeeper) throws -> ResponseRepresentable {
        
        try zookeeper.delete()
        return JSON([:])
    }
    
    func makeResource() -> Resource<Zookeeper> {
    
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
