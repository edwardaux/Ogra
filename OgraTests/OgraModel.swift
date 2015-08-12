//
//  OgraModel.swift
//  Ogra
//
//  Created by Craig Edwards on 27/07/2015.
//  Copyright © 2015 Craig Edwards. All rights reserved.
//

import Foundation
import Argo
import Ogra

// MARK: - Basic data model
struct User {
	let id: Int
	let name: String
	let email: String?
	let pet: Pet?
    let nicknames: [String]?
}
struct Pet {
	let name: String
}

// MARK: - JSON Encoding and Decoding
extension User: Decodable, Encodable {
    static func create(id: Int)(name: String)(email: String?)(pet: Pet?)(nicknames: [String]?) -> User {
        return User(id:id, name:name, email:email, pet:pet, nicknames:nicknames)
    }
    
    static func decode(j: JSON) -> Decoded<User> {
        return create
            <^> j <|   "id"
            <*> j <|   "name"
            <*> j <|?  "email"
            <*> j <|?  "pet"
            <*> j <||? "nicknames"
    }
    
    func encode() -> JSON {
        return JSON.Object([
            "id"        : self.id.encode(),
            "name"      : self.name.encode(),
            "email"     : self.email.encode(),
            "pet"       : self.pet.encode(),
            "nicknames" : self.nicknames.encode()
        ])
    }
}

extension Pet: Decodable, Encodable {
	static func create(name: String) -> Pet {
		return Pet(name:name)
	}
	
	static func decode(j: JSON) -> Decoded<Pet> {
		return create
			<^> j <| "name"
	}
	
	func encode() -> JSON {
		return JSON.Object([
			"name" : self.name.encode(),
		])
	}
}
