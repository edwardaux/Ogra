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
	fileprivate func toJSON(_ jsonString: String) -> JSON {
		let jsonData = jsonString.data(using: String.Encoding.utf8)!
		let jsonObject: AnyObject = try! JSONSerialization.jsonObject(with: jsonData, options:JSONSerialization.ReadingOptions()) as AnyObject
		return JSON(jsonObject)
	}

	func testNullPet() {
		let jsonIn = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":null, \"nicknames\":[\"Johnny\"], \"accounts\":{\"gmail\":\"john\"}, \"happy\":true }")
		let user = User.decode(jsonIn).value!
		let jsonOut = user.encode()

		XCTAssertEqual(jsonIn, jsonOut)
	}

	func testNullNicknames() {
		let jsonIn = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":null, \"nicknames\":null, \"accounts\":{\"gmail\":\"john\"}, \"happy\":true }")
		let user = User.decode(jsonIn).value!
		let jsonOut = user.encode()

		XCTAssertEqual(jsonIn, jsonOut)
	}

	func testNullAccounts() {
		let jsonIn = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":null, \"nicknames\":[\"Johnny\"], \"accounts\":null, \"happy\":true }")
		let user = User.decode(jsonIn).value!
		let jsonOut = user.encode()

		XCTAssertEqual(jsonIn, jsonOut)
	}

	func testWithPet() {
		let jsonIn = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":{\"name\":\"Rex\"}, \"nicknames\":[\"Johnny\"], \"accounts\":{\"gmail\":\"john\"}, \"happy\":true }")
		let user = User.decode(jsonIn).value!
		let jsonOut = user.encode()

		XCTAssertEqual(jsonIn, jsonOut)
	}

	func testPassingToJSONSerialization() {
		let json = toJSON("{ \"id\":123, \"name\":\"John\", \"email\":\"john@gmail.com\", \"pet\":{\"name\":\"Rex\"}, \"nicknames\":[\"Johnny\"], \"accounts\":{\"gmail\":\"john\"}, \"happy\":true }")
		let user = User.decode(json).value!

		let jsonObject = user.encode().JSONObject()
		let data = try! JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions.prettyPrinted)
		let string = NSString(data:data, encoding:String.Encoding.utf8.rawValue)!
		// a bit tricky to test this because changes to Foundation will result in different ordering of the output.
		// for now, we just dump it out. if there were problems converting to JSON (eg. dataWithJSONObject returning
		// a nil) then we would have trapped by now
		print(string)
	}

	func testRawRepresentableStringType() {
		let continent: Continent = .NorthAmerica
		let json: JSON = .string(continent.rawValue)
		let encoded = continent.encode()
		XCTAssertEqual(json, encoded)
	}
	
	func testRawRepresentableIntType() {
		let dialingCode: IntDialingCode = .unitedStates
		let json: JSON = .number(dialingCode.rawValue as NSNumber)
		let encoded = dialingCode.encode()
		XCTAssertEqual(json, encoded)
	}
	
	func testRawRepresentableDoubleType() {
		let dialingCode: DoubleDialingCode = .unitedStates
		let json: JSON = .number(dialingCode.rawValue as NSNumber)
		let encoded = dialingCode.encode()
		XCTAssertEqual(json, encoded)
	}
	
	func testRawRepresentableFloatType() {
		let dialingCode: FloatDialingCode = .unitedStates
		let json: JSON = .number(dialingCode.rawValue as NSNumber)
		let encoded = dialingCode.encode()
		XCTAssertEqual(json, encoded)
	}
	
	func testRawRepresentableUIntType() {
		let dialingCode: UIntDialingCode = .unitedStates
		let json: JSON = .number(dialingCode.rawValue as NSNumber)
		let encoded = dialingCode.encode()
		XCTAssertEqual(json, encoded)
	}
	
	func testRawRepresentableUInt64Type() {
		let dialingCode: UInt64DialingCode = .unitedStates
		let json: JSON = .number(NSNumber(value: dialingCode.rawValue))
		let encoded = dialingCode.encode()
		XCTAssertEqual(json, encoded)
	}
	
	func testConversionToAnyObject() {
		XCTAssertEqual(JSON.null.JSONObject() as? NSNull, NSNull())
		XCTAssertEqual(JSON.string("42").JSONObject() as? String, "42")
		XCTAssertEqual(JSON.number(NSNumber(value: 42)).JSONObject() as? Int, 42)
		XCTAssertEqual(JSON.array([JSON.string("42")]).JSONObject() as! [String], ["42"])
		XCTAssertEqual(JSON.object(["life" : JSON.string("42")]).JSONObject() as! [String : String], ["life" : "42"])
	}
	
	func testTypesEncodeProperly() {
		XCTAssertEqual(JSON.null.encode(), JSON.null)
		XCTAssertEqual("42".encode(), JSON.string("42"))
		XCTAssertEqual(true.encode(), JSON.bool(true))
		XCTAssertEqual(false.encode(), JSON.bool(false))
		XCTAssertEqual(Int(42).encode(), JSON.number(NSNumber(value: 42)))
		XCTAssertEqual(Double(42.42).encode(), JSON.number(NSNumber(value: 42.42)))
		XCTAssertEqual(Float(42.42).encode(), JSON.number(NSNumber(value: Float(42.42))))
		XCTAssertEqual(UInt(42).encode(), JSON.number(NSNumber(value: 42)))
		XCTAssertEqual(UInt64(42).encode(), JSON.number(NSNumber(value: 42)))
		XCTAssertEqual(("42" as String?).encode(), JSON.string("42"))
		XCTAssertEqual((nil as String?).encode(), JSON.null)
	}
}
