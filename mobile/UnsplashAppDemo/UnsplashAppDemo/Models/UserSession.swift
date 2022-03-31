//
//  UserSession.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 06/03/22.
//

import Foundation
enum UnsplashError: Error {
	case badRequest
	case unauthorized
	case forbidden
	case notFound
	case serverError
}

protocol AccessTokenResponse: Codable {
	var access_token: String {get}
	var token_type: String {get}
	var scope: String {get}
	var created_at: Double {get}
}
struct UnsplashAccessTokenResponse:AccessTokenResponse {
	var access_token: String
	var token_type: String
	var scope: String
	var created_at: Double
}

protocol UserSession: Codable {
	//var accessTokenResponse: AccessTokenResponse {get}
	var accessToken: String {get}
}

class UnsplashUserSession: UserSession {
	var accessToken: String
	
	init(accessTokenResponse: AccessTokenResponse){
		self.accessToken = accessTokenResponse.access_token
	}
}
