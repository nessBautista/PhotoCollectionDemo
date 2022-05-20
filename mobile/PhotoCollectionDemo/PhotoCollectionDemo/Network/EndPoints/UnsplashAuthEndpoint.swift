//
//  AuthEndPoint.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
enum UnsplashAuthEndpoint {
	case authorize(clientId:String, redirectURL:String, responseType: String, scope: String)
	case token(clientId:String,
			   clientSecret:String,
			   redirectURL:String,
			   code: String,
			   grantType: String = "authorization_code")
	case profile(userName: String, accessToken: AccessToken)
	
	static func buildAuthorizeEndPoint(appSettings: AppSettingsProtocol) -> UnsplashAuthEndpoint {
		let apiSettings = appSettings.apiSettings
		let clientId = apiSettings.clientId
		let redirect = apiSettings.redirect
		let basicAccess = apiSettings.basicAccess
		
		let authEnpoint = UnsplashAuthEndpoint.authorize(clientId: clientId,
														  redirectURL: redirect,
														  responseType: "code",
														  scope: basicAccess)
		return authEnpoint
	}
}

extension UnsplashAuthEndpoint : Endpoint {
	var baseURL: URL {
		switch self {
		case .authorize(_, _, _, _),.token(_, _, _, _, _):
			return URL(string:"https://unsplash.com/")!
		case .profile(_, _):
			return URL(string:"https://api.unsplash.com/")!
		}
	}
	
	var endPoint: String {
		switch self {
		case .authorize(_, _, _, _):
			return "oauth/authorize"
		case .token(_, _, _, _, _):
			return "oauth/token"
		case .profile(_, _):
			return "me"
		}
	}
	
	var request: URLRequest {
		let url = self.baseURL.appendingPathComponent(self.endPoint)
		var request = URLRequest(url: url)
		let encoder = self.encoder
		request.allHTTPHeaderFields = self.headers
		
		switch self {
		case .authorize(_, _, _, _):
			request.httpMethod = "GET"
			encoder.encode(request: &request, params: self.parameters)
			return request
		case .token(_, _, _, _, _):
			request.httpMethod = "POST"
			encoder.encode(request: &request, params: self.parameters)
			return request
		case .profile(_, _):
			request.httpMethod = "GET"
			return request
		}
	}
	
	var encoder: EncoderType {
		switch self {
		case .authorize(_, _, _, _):
			return .url
		case .token(_, _, _, _, _):
			return .json
		case .profile(_, _):
			return .url
		}
	}
	
	var parameters: [String : Any] {
		var params:[String:Any] = [:]
		switch self {
		case .authorize(let clientId, let redirectURL, let responseType, let scope):
			//TODO: Parameters can be a struct, so we can use JSONEncoders
			params["client_id"] = clientId
			params["redirect_uri"] = redirectURL
			params["response_type"] = responseType
			params["scope"] = scope
			return params
		case .token(let clientId, let clientSecret, let redirectURL, let code, let grantType):
			params["client_id"] = clientId
			params["client_secret"] = clientSecret
			params["redirect_uri"] = redirectURL
			params["code"] = code
			params["grant_type"] = grantType
			return params
		case .profile(_,_):
			return params
		}
	}
	
	var headers: [String : String] {
		var headers: [String: String] = [:]
		headers["Content-Type"] = "application/json; charset=utf-8"
		switch self {
		case .authorize(_ ,_ , _, _), .token(_ ,_ , _, _,_):
			break
		case .profile(_, let accessToken):
			headers["Authorization"] = "Bearer \(accessToken.access_token)"
			
		}
		return headers
	}
}
