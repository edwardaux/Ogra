//
//  Encodable.swift
//  Ogra
//
//  Created by Craig Edwards on 27/07/2015.
//  Copyright © 2015 Craig Edwards. All rights reserved.
//

import Foundation
import Argo

public protocol Encodable {
	func encode() -> JSON
}

extension JSON: Encodable {
	public func encode() -> JSON {
		return self
	}
}

extension String: Encodable {
	public func encode() -> JSON {
		return .String(self)
	}
}

extension Bool: Encodable {
	public func encode() -> JSON {
		return .Number(self ? 1 : 0)
	}
}

extension Int: Encodable {
	public func encode() -> JSON {
		return .Number(self)
	}
}

extension Double: Encodable {
	public func encode() -> JSON {
		return .Number(self)
	}
}

extension Float: Encodable {
	public func encode() -> JSON {
		return .Number(self)
	}
}

extension UInt: Encodable {
	public func encode() -> JSON {
		return .Number(self)
	}
}

extension Optional where Wrapped: Encodable {
	public func encode() -> JSON {
		switch self {
		case .None:        return .Null
		case .Some(let v): return v.encode()
		}
	}
}

extension CollectionType where Self: DictionaryLiteralConvertible, Self.Key: StringLiteralConvertible, Self.Value: Encodable, Generator.Element == (Self.Key, Self.Value) {
	public func encode() -> JSON {
		var values = [String : JSON]()
		for (key, value) in self {
			values[String(key)] = value.encode()
		}
		return .Object(values)
	}
}

extension Optional where Wrapped: protocol<CollectionType, DictionaryLiteralConvertible>, Wrapped.Key: StringLiteralConvertible, Wrapped.Value: Encodable, Wrapped.Generator.Element == (Wrapped.Key, Wrapped.Value) {
	public func encode() -> JSON {
		return self.map { $0.encode() } ?? .Null
	}
}

extension CollectionType where Generator.Element: Encodable {
	public func encode() -> JSON {
		return JSON.Array(self.map { $0.encode() })
	}
}

extension Optional where Wrapped: CollectionType, Wrapped.Generator.Element: Encodable {
	public func encode() -> JSON {
		return self.map { $0.encode() } ?? .Null
	}
}

extension Encodable where Self: RawRepresentable, Self.RawValue == String {
    public func encode() -> JSON {
        return .String(self.rawValue)
    }
}

extension Encodable where Self: RawRepresentable, Self.RawValue == Int {
    public func encode() -> JSON {
        return .Number(self.rawValue)
    }
}

extension Encodable where Self: RawRepresentable, Self.RawValue == Double {
    public func encode() -> JSON {
        return .Number(self.rawValue)
    }
}

extension Encodable where Self: RawRepresentable, Self.RawValue == Float {
    public func encode() -> JSON {
        return .Number(self.rawValue)
    }
}

extension Encodable where Self: RawRepresentable, Self.RawValue == UInt {
    public func encode() -> JSON {
        return .Number(self.rawValue)
    }
}

extension JSON {
	public func JSONObject() -> AnyObject {
		switch self {
		case .Null:              return NSNull()
		case .String(let value): return value
		case .Number(let value): return value
		case .Array(let array):  return array.map { $0.JSONObject() }
		case .Object(let object):
			var dict: [Swift.String : AnyObject] = [:]
			for key in object.keys {
				if let value = object[key] {
					dict[key] = value.JSONObject()
				} else {
					dict[key] = NSNull()
				}
			}
			return dict
		}
	}
}
