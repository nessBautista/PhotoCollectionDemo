//
//  Encoder.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 26/02/22.
//

import Foundation
import OrderedCollections
class URLRequestEncoder: EncoderProtocol {
    var request: URLRequest
    
    init(request: URLRequest) {
		self.request = request
    }
    
    func encode(params: OrderedDictionary<String,Any>) throws {
		let url = try validateURL()
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){
            urlComponents.queryItems = []
            for (key, value) in params {
                
				let queryItem = URLQueryItem(name: key,
											 value: "\(value)"
                                                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                
				urlComponents.queryItems?.append(queryItem)
            }
            self.request.url = urlComponents.url
        }
    }
}

class JSONRequestEncoder: EncoderProtocol {
	var request: URLRequest
	
	init(request: URLRequest) {
		self.request = request
	}
	
	func encode(params: OrderedDictionary<String,Any>) throws {
		try validateURL()
		
		if let dictionaryData = try? JSONSerialization
										.data(withJSONObject: params.toDictionary(),
											  options: []) {
			self.request.httpBody = dictionaryData
		}		
	}
}
