//
//  OgraTests.swift
//  OgraTests
//
//  Created by Craig Edwards on 27/07/2015.
//  Copyright © 2015 Craig Edwards. All rights reserved.
//

import XCTest
import Argo
import Ogra

class OgraTests: XCTestCase {
	private func toJSON(jsonString: String) -> JSON {
		let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding)!
		let jsonObject: AnyObject = try! NSJSONSerialization.JSONObjectWithData(jsonData, options:NSJSONReadingOptions())
		return JSON.parse(jsonObject)
	}
	
	func testNullPet() {
		let jsonIn = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":null, \"nicknames\":[\"Johnny\"] }")
		let user = User.decode(jsonIn).value!
		let jsonOut = user.encode()
		
		XCTAssertEqual(jsonIn, jsonOut)
	}
	
	func testWithPet() {
		let jsonIn = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":{\"name\":\"Rex\"}, \"nicknames\":[\"Johnny\"] }")
		let user = User.decode(jsonIn).value!
		let jsonOut = user.encode()
		
		XCTAssertEqual(jsonIn, jsonOut)
	}

	func testPassingToJSONSerialization() {
		let json = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":{\"name\":\"Rex\"}, \"nicknames\":[\"Johnny\"] }")
		let user = User.decode(json).value!

		let jsonObject = user.encode().JSONObject()
		let data = try! NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions.PrettyPrinted)
		let string = NSString(data:data, encoding:NSUTF8StringEncoding)!
		// a bit tricky to test this because changes to Foundation will result in different ordering of the output.
		// for now, we just dump it out. if there were problems converting to JSON (eg. dataWithJSONObject returning
		// a nil) then we would have trapped by now
		print(string)
	}
}
