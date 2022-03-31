//
//  TestUtilities.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 26/02/22.
//

import Foundation
import OrderedCollections

class TestUtilities {
    class func very(request: URLRequest, contains params:OrderedDictionary<String,Any>) -> Bool {
        guard let url = request.url else {
            return false
        }
        
        if let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems {
            for item in queryItems{
                if params[item.name] == nil {
                    return false
                }
            }
            return true
        }
        return params.count == 0
    }
	
	class func verifyHTTPBody(request: URLRequest, contains params:OrderedDictionary<String,Any>) -> Bool {
		
		if let data = request.httpBody,
		   let httpBodyDictionary = try? JSONSerialization.jsonObject(with: data,
		options: .allowFragments) as? [String:AnyObject] {
			// Check for the same number of parameters
			if params.count != httpBodyDictionary.count {
				return false
			}
			
			// Check Keys are found on the httpBodyDictionary
			for item in params {
				if httpBodyDictionary[item.key] == nil {
					return false
				}
			}
		} else {
			return false
		}

		return true
	}
}
