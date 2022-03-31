//
//  UserSessionCodable.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 06/03/22.
//

import Foundation
/* User session Codable is responsible to support the tasks that creates and request UserSession
*/
protocol UserSessionCodable {
	var authorizationCode: String? {get set}
	var tokenAccessResponse:Decodable? {get set}
	func getAuthorizationCode(from url: URL) -> String?
	func decodeAccessToken<Model:Decodable>(data: Data?, model: Model.Type) -> Model?
	func makeUserSession() -> UserSession?
	func makeUserSession<Model:Decodable>(data:Data?, model: Model.Type) -> UserSession? 
}

class UnsplashUserSessionCodable: UserSessionCodable {

	var authorizationCode: String? = nil
	var tokenAccessResponse:Decodable?
	
	func getAuthorizationCode(from url: URL) -> String? {
		if let query = url.query,
		   query.contains("code="),
		   query.split(separator: "=").count == 2 {
			self.authorizationCode = String(query.split(separator: "=")[1])
			return self.authorizationCode
		}
		return nil
	}
	
	func decodeAccessToken<Model:Decodable>(data: Data?, model: Model.Type) -> Model? {
		guard let accessData = data else { return nil }
		
		if let accessToken = try? JSONDecoder().decode(Model.self, from: accessData) {
			tokenAccessResponse = accessToken
			return accessToken
		}
		
		return nil
	}
	
	func makeUserSession() -> UserSession? {
		if let accessTokenResponse = tokenAccessResponse as? AccessTokenResponse {
			return UnsplashUserSession(accessTokenResponse: accessTokenResponse)
		}
		return nil
	}
	
	func makeUserSession<Model:Decodable>(data:Data?, model: Model.Type) -> UserSession? {			
		if let accessData = data,
		   let accessToken = try? JSONDecoder().decode(Model.self, from: accessData) {
			tokenAccessResponse = accessToken
		}
		
		if let accessTokenResponse = tokenAccessResponse as? AccessTokenResponse {
			return UnsplashUserSession(accessTokenResponse: accessTokenResponse)
		}
		return nil
	}
}
