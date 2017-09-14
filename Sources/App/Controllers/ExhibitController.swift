//
//  ExhibitController.swift
//  Zoo
//
//  Created by Tendai Prince Dzonga on 4/22/17.
//
//

import Foundation
import Vapor
import HTTP

struct ExhibitController {
    
    func index(_ request: Request) throws -> ResponseRepresentable {
        
        return try Exhibit.all().makeNode().converted(to: JSON.self)
    }
    
    func create(_ request: Request) throws -> ResponseRepresentable {
        
        guard let exhibitType = request.data["exhibitType"]?.string  else { throw Abort.badRequest }
        
        var exhibit = Exhibit(exhibitType: exhibitType)
        try exhibit.save()
        
        return try JSON(node: [
                "exibit": exhibit.id
            ])
    }
    
    
}
