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
	let accounts: [String:String]?
}
struct Pet {
	let name: String
}

enum Continent: String {
    case Asia
    case Africa
    case NorthAmerica = "North America"
    case SouthAmerica = "South America"
    case Antarctica
    case Europe
    case Australia
}

enum IntDialingCode: Int {
    case UnitedKingdom = 44
    case UnitedStates = 1
}

enum DoubleDialingCode: Double {
    case UnitedKingdom = 44
    case UnitedStates = 1
}

enum FloatDialingCode: Float {
    case UnitedKingdom = 44
    case UnitedStates = 1
}

enum UIntDialingCode: UInt {
    case UnitedKingdom = 44
    case UnitedStates = 1
}


// MARK: - JSON Encoding and Decoding
extension User: Decodable, Encodable {
	static func create(id: Int)(name: String)(email: String?)(pet: Pet?)(nicknames: [String]?)(accounts: [String:String]?) -> User {
		return User(id:id, name:name, email:email, pet:pet, nicknames:nicknames, accounts:accounts)
	}

	static func decode(j: JSON) -> Decoded<User> {
		return create
			<^> j <|   "id"
			<*> j <|   "name"
			<*> j <|?  "email"
			<*> j <|?  "pet"
			<*> j <||? "nicknames"
			<*> .optional(flatReduce(["accounts"], initial: j, combine: decodedJSON) >>- Dictionary<String, String>.decode)
	}
	
	func encode() -> JSON {
		return JSON.Object([
			"id"        : self.id.encode(),
			"name"      : self.name.encode(),
			"email"     : self.email.encode(),
			"pet"       : self.pet.encode(),
			"nicknames" : self.nicknames.encode(),
			"accounts"  : self.accounts.encode()
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

extension Continent: Decodable, Encodable {}

extension IntDialingCode: Decodable, Encodable {}
extension DoubleDialingCode: Encodable {}
extension FloatDialingCode: Encodable {}
extension UIntDialingCode: Encodable {}
