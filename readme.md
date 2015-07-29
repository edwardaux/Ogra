# Ogra
Provides the ability to convert from a model object into an Argo JSON representation. Uses the data structures provided by [Argo](https://github.com/thoughtbot/Argo) but instead of converting the JSON to a model, it goes the other way around, hence "Ogra" (do you see what I did there?)

## Usage
When decoding from JSON using Argo, the business objects need to conform to the `Decodable` protocol. In order to convert back to JSON using Ogra, the business objects need to conform to the `Encodable` protocol. An example of this looks like:

```swift
extension User: Encodable {
	func encode() -> JSON {
		return JSON.Object([
			"id"    : self.id.encode(),
			"name"  : self.name.encode(),
			"email" : self.email.encode(),
		])
	}
}

let user = ...
let jsonObject = user.encode().JSONObject()

// jsonObject is an `AnyObject` that you can pass to NSJSONSerialization. For example:
let data = NSJSONSerialization.dataWithJSONObject(jsonObject, options: NSJSONWritingOptions.PrettyPrinted)
```

Ogra provides default encoding behaviour for the basic types like `String`, `Int`, `Bool`, `Double`, `Float`, `Array<Encodable>`, `Dictionary<String, Encodable>`, and `Optional<Encodable>`, so generally speaking you only need to provide an `encode()` function in your model classes that return a `JSON.Object` enum case.

## Installation
Add the following to your Cartfile:

```
github "edwardaux/Ogra"
```

Then run `carthage update`.

## Licence
Ogra is Copyright(c) 2015 Craig Edwards. It may be redistributed under the terms specified by the [MIT licence](licence.md).