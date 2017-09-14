import Vapor
import VaporSQLite

let drop = Droplet()
try drop.addProvider(VaporSQLite.Provider.self)

let zookeepers = ZooController()
let animals = AnimalController()
let foods = FoodController()


drop.preparations.append(Animal.self)
drop.preparations.append(Zookeeper.self)
drop.preparations.append(Food.self)
drop.preparations.append(Exhibit.self)


drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("db") { request in
    
    //let result = try drop.database?.driver.raw("SELECT sqlite_version()")
    let result = try drop.database?.driver.raw("select sqlite_version()")
    return try JSON(node: result)
}

drop.get("animals", Animal.self) { request, animal in
    
    return animal.name
    
}


drop.get("animals", "search", ":animalName") { request in
    
    
    guard let animalName = request.parameters["animalName"]?.string else { throw Abort.custom(status: .preconditionFailed, message: "include animal name") }
    
    let animalQuery = try Animal.query().filter("name", animalName)
    
    return try JSON(node: Animal.query().filter("name", animalName).all().makeNode())
    
}

drop.get("zookeepers", "search", ":lastName") { request in
    
    guard let lastName = request.parameters["lastName"]?.string else { throw Abort.badRequest }
    
    return try JSON(node: Zookeeper.query().filter("lastName", lastName).all().makeNode())
    
}

drop.get("foods", "search", ":name") { request in
    
    guard let name = request.parameters["name"]?.string else { throw Abort.badRequest }
    
    return try JSON(node: Food.query().filter("foodName", name).all().makeNode())
    
}

drop.get("foods", "type", ":type") { request in
    
    guard let type = request.parameters["type"]?.string else { throw Abort.badRequest }
    
    return try JSON(node: Food.query().filter("foodType", type).all().makeNode())
}


drop.resource("animals", animals)
drop.resource("zookeepers", zookeepers)
drop.resource("foods", foods)





drop.run()
