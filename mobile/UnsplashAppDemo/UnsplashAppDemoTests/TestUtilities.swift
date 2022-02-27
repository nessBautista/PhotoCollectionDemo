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
}
