//
//  UnsplashPhotosEndPoint.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
enum UnsplashPhotosEndPoint {
	case photos(Int, Int, String, AccessToken)
}

extension UnsplashPhotosEndPoint: Endpoint {
	var baseURL: URL {
		return URL(string:"https://api.unsplash.com/")!
	}
	
	var endPoint: String {
		switch self {
		case .photos:
			return "photos"
		}
	}
	
	var request: URLRequest {
		let url = self.baseURL.appendingPathComponent(self.endPoint)
		var request = URLRequest(url: url)
		request.allHTTPHeaderFields = self.headers
		self.encoder.encode(request: &request, params: self.parameters)
		
		switch self {
		case .photos(_, _, _, _):
			request.httpMethod = "GET"
			return request
		}
	}
	
	var encoder: EncoderType {
		switch self {
		case .photos(_, _, _, _):
			return .url
		}
	}
	
	var parameters: [String : Any] {
		var params:[String : Any] = [:]
		switch self {
		case .photos(let page, let perPage, let orderBy, _):
			params["page"] = page
			params["per_page"] = perPage
			params["order_by"] = orderBy
			return params
		}
	}
	
	var headers: [String : String] {
		var headers: [String: String] = [:]
		headers["Content-Type"] = "application/json; charset=utf-8"
		switch self {
		case .photos(_, _, _, let accessToken):
			headers["Authorization"] = "Bearer \(accessToken.access_token)"
			return headers
		}
	}
}
