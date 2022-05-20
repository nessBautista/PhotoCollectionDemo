//
//  UnsplashRemoteAuthAPI.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Combine
import Foundation
protocol AuthRemoteAPI: RemoteAPI {
	func getAuthorizeEndPoint() -> UnsplashAuthEndpoint
	func createAccessToken(code:String) -> AnyPublisher<AccessToken, NetworkError>
	func getUserSession(token: AccessToken)-> AnyPublisher<UserSession, NetworkError>
	func getUserProfile(token:AccessToken)  -> AnyPublisher<UserProfile, NetworkError>
}

class UnsplashRemoteAuthAPI: AuthRemoteAPI {
	let session: Transport
	let appSettings:AppSettingsProtocol
	
	init(session: Transport,
		 appSettings: AppSettingsProtocol) {
		self.session = session
		self.appSettings = appSettings
	}
	
	func getAuthorizeEndPoint() -> UnsplashAuthEndpoint{
		UnsplashAuthEndpoint.buildAuthorizeEndPoint(appSettings: appSettings)
	}
	
	func createAccessToken(code:String) -> AnyPublisher<AccessToken, NetworkError> {
		let apiSettings = self.appSettings.apiSettings
		let clientId = apiSettings.clientId
		let clientSecret = apiSettings.clientSecret
		let redirect = apiSettings.redirect
		let tokenEndpoint = UnsplashAuthEndpoint.token(clientId: clientId,
													   clientSecret: clientSecret,
													   redirectURL: redirect,
													   code: code)
		return self.fetch(endpoint: tokenEndpoint)
					.eraseToAnyPublisher()
	}
	
	func getUserProfile(token:AccessToken)  -> AnyPublisher<UserProfile, NetworkError>  {
		let profileEndPoint = UnsplashAuthEndpoint.profile(userName: "me",
														   accessToken: token)
		return self.fetch(endpoint: profileEndPoint)
					.eraseToAnyPublisher()
	}
	
	func getUserSession(token: AccessToken) -> AnyPublisher<UserSession, NetworkError> {
		self.getUserProfile(token: token)
			.print()
			.map({profile in
				UserSession(accessToken: token, profile: profile)
			})
			.mapError({ error in
				print(error)
				return NetworkError.unknown
			})
			.eraseToAnyPublisher()
	}
	
	func fetch<Element:Decodable>(endpoint: Endpoint) -> AnyPublisher<Element, NetworkError> {
		session.fetch(endpoint.request)
			.decode(type: Element.self, decoder: JSONDecoder())
			.print()
			.mapError({ error in
				//TODO: handling error
				return NetworkError.unknown
			})
			.eraseToAnyPublisher()
	}
}
