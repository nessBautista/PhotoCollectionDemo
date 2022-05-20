//
//  EncoderType.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 15/04/22.
//

import Foundation
enum EncoderType {
	case url
	case json
}

extension EncoderType {
	func encode(request: inout URLRequest, params:[String:Any]){		 
		switch self {
		case .url:
			self.encodeURL(request: &request, params:params)
		case .json:
			self.encodeJson(request: &request, params: params)
		}
	}
	
	private func encodeURL(request: inout URLRequest, params:[String:Any]) {
		guard let url = request.url else { return }
		if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
			urlComponents.queryItems = [URLQueryItem]()
			for (key, value) in params {
				let queryItem = URLQueryItem(name: key,
											 value: "\(value)"
												.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
				urlComponents.queryItems?.append(queryItem)
			}
			request.url = urlComponents.url
		}
	}
	
	private func encodeJson(request: inout URLRequest, params:[String:Any]) {
		if let jsonData = try? JSONSerialization.data(withJSONObject: params,
													  options: .prettyPrinted){
			request.httpBody = jsonData
		}
	}
}
