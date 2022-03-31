//
//  UnsplashNetworkLayer.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 09/03/22.
//

import Foundation
import Combine

class UnsplashNetworkLayer: NetworkLayer {
	func fetch(_ params: [String : Any]?) -> AnyPublisher<Data?, Error> {
		// TODO: create real request for usersession
		//return PassthroughSubject<Data?, Error>().eraseToAnyPublisher()
		Future<Data?, Error>{ promise in
			DispatchQueue.main.asyncAfter(deadline: .now()+2) {
				let session = MockAccessTokenResponse().serialize()
				promise(.success(session))
			}
		}.eraseToAnyPublisher()
	}
}

class MockAccessTokenResponse: AccessTokenResponse {
	var access_token: String = "091343ce13c8ae780065ecb3b13dc903475dd22cb78a05503c2e0c69c5e98044"
	
	var token_type: String = "bearer"
	
	var scope: String = "public read_photos write_photos"
	
	var created_at: Double = 1436544465
}
extension MockAccessTokenResponse {
	func serialize()-> Data? {
		let encoder = JSONEncoder()
		if let encoded = try? encoder.encode(self) {
			return encoded
		}
		return nil
	}
}
