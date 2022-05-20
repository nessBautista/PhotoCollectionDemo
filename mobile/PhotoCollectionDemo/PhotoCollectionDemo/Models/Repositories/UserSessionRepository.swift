//
//  UserSessionRepository.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import Foundation
import Combine

protocol UserSessionRepositoryProtocol {
	// LOCAL DB
	func readUserSession() -> AnyPublisher<UserSession, StorageError>
	func writeUserSession(_ session: UserSession) -> AnyPublisher<UserSession, StorageError>
	// Network
	func createUserSession(authCode: String)->AnyPublisher<UserSession, StorageError>
}

class UserSessionRepository: UserSessionRepositoryProtocol {
	let networkLayer: AuthRemoteAPI
	let storageLayer: UserSessionDataStore
	
	init(networkLayer: AuthRemoteAPI,
		 storageLayer: UserSessionDataStore) {
		self.networkLayer = networkLayer
		self.storageLayer = storageLayer
	}
	
	// READ
	// Get initial URL for the Unsplash WebView
	func getAuthorizeEndPoint() -> UnsplashAuthEndpoint {
		networkLayer.getAuthorizeEndPoint()
	}
	
	// Checks if there is a user session in local storage
	func readUserSession() -> AnyPublisher<UserSession, StorageError> {
		Future<UserSession, StorageError> {promise in
			DispatchQueue.global(qos: .background).async {
				do {
					let userSessionData = try self.storageLayer.readUserSession()
					if let session = try? JSONDecoder()
						.decode(UserSession.self, from: userSessionData) {
						promise(.success(session))
					} else {
						//TODO: if the session decoding fails, we hava a dead point here
						promise(.failure(StorageError.emptySession("")))
					}
					
				} catch {
					promise(.failure(StorageError.emptySession("")))
				}
			}
		}
		.eraseToAnyPublisher()
	}
	
	// Create
	// TODO: Create a chain of Combine Network Requests
	
	func createUserSession(authCode: String) -> AnyPublisher<UserSession, StorageError> {
		networkLayer.createAccessToken(code: authCode)
			.flatMap({self.networkLayer.getUserSession(token:$0)})
			.mapError({_ in StorageError.unknown})
			.flatMap({self.storageLayer.writeUserSession(userSession: $0)})
			.eraseToAnyPublisher()
	}

	// TODO: is there any case where we need to write the user session directly?
	func writeUserSession(_ session: UserSession) -> AnyPublisher<UserSession, StorageError> {
		self.storageLayer.writeUserSession(userSession: session)
	}
}

	

