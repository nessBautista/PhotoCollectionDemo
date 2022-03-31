//
//  AuthUserSessionRepo.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 06/03/22.
//

import Foundation
import Combine

protocol AuthUserSessionRepo {
	var networkLayer: NetworkLayer {get set}
	var sessionCodable: UserSessionCodable {get}
	func fetchUserSession() ->AnyPublisher<UserSession?, Error>
}

class UnsplashAuthUserSessionRepo: AuthUserSessionRepo {
	var networkLayer: NetworkLayer
	var sessionCodable: UserSessionCodable
	
	init(networkLayer: NetworkLayer,
		 sessionCodable: UserSessionCodable) {
		self.networkLayer = networkLayer
		self.sessionCodable = sessionCodable
	}
	
	func fetchUserSession() ->AnyPublisher<UserSession?, Error>{
		self.networkLayer.fetch(nil)
			.tryMap({self.sessionCodable
						.makeUserSession(data: $0,
									     model: UnsplashAccessTokenResponse.self)})
			.eraseToAnyPublisher()
	}
}
