//
//  OrderedDictionery+Extensions.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 09/03/22.
//

import Foundation
import OrderedCollections

extension OrderedDictionary{
	func toDictionary() -> Dictionary<String ,Any> {
		var dict:[String: Any] = [:]
		for (key, value) in self {
			if let keyString = key as? String {
				dict[keyString] = value
			}
		}
		return dict
	}
}


