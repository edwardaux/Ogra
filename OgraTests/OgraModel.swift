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
import Runes

// MARK: - Basic data model
struct User {
	let id: Int
	let name: String
	let email: String?
	let pet: Pet?
	let nicknames: [String]?
	let accounts: [String:String]?
	let happy: Bool
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
    case unitedKingdom = 44
    case unitedStates = 1
}

enum DoubleDialingCode: Double {
    case unitedKingdom = 44
    case unitedStates = 1
}

enum FloatDialingCode: Float {
    case unitedKingdom = 44
    case unitedStates = 1
}

enum UIntDialingCode: UInt {
    case unitedKingdom = 44
    case unitedStates = 1
}

enum UInt64DialingCode: UInt64 {
    case unitedKingdom = 44
    case unitedStates = 1
}

// MARK: - JSON Encoding and Decoding
extension User: Decodable, Encodable {
	static func create(id: Int) -> (_ name: String) -> (_ email: String?) -> (_ pet: Pet?) -> (_ nicknames: [String]?) -> (_ accounts: [String:String]?) -> (_ happy: Bool) -> User {
		return
			{ name in
				{ email in
					{ pet in
						{ nicknames in
							{ accounts in
								{ happy in
									return User(id:id, name:name, email:email, pet:pet, nicknames:nicknames, accounts:accounts, happy:happy)
								}
							}
						}
					}
				}
			}
	}

	static func decode(_ j: JSON) -> Decoded<User> {
		return User.create
			<^> j <|   "id"
			<*> j <|   "name"
			<*> j <|?  "email"
			<*> j <|?  "pet"
			<*> j <||? "nicknames"
			<*> .optional(flatReduce(["accounts"], initial: j, combine: decodedJSON) >>- Dictionary<String, String>.decode)
			<*> j <|   "happy"
	}
	
	func encode() -> JSON {
		return JSON.object([
			"id"        : self.id.encode(),
			"name"      : self.name.encode(),
			"email"     : self.email.encode(),
			"pet"       : self.pet.encode(),
			"nicknames" : self.nicknames.encode(),
			"accounts"  : self.accounts.encode(),
			"happy"     : self.happy.encode()
		])
	}
}

extension Pet: Decodable, Encodable {
	static func create(_ name: String) -> Pet {
		return Pet(name:name)
	}
	
	static func decode(_ j: JSON) -> Decoded<Pet> {
		return create
			<^> j <| "name"
	}
	
	func encode() -> JSON {
		return JSON.object([
			"name" : self.name.encode(),
		])
	}
}

extension Continent: Decodable, Encodable {}

extension IntDialingCode: Decodable, Encodable {}
extension DoubleDialingCode: Encodable {}
extension FloatDialingCode: Encodable {}
extension UIntDialingCode: Encodable {}
extension UInt64DialingCode: Encodable {}
