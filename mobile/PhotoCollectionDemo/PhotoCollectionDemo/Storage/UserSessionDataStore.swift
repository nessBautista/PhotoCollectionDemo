//
//  UserSessionDataStore.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 07/04/22.
//

import Foundation
import Combine

public protocol UserSessionDataStore {
	func readUserSession() throws ->  Data
	func writeUserSession(userSession: UserSession) -> AnyPublisher<UserSession, StorageError>
}

public class UserDefaultsUserSessionStore: UserSessionDataStore {
	let db: UserDefaults
	
	init(database:UserDefaults = UserDefaults.standard){
		self.db = database
	}
	
	public func readUserSession() throws ->  Data {
		if let userSessionData = self.db.value(forKey: Constants.Storage.userSession) as? Data {
			return userSessionData
		} else {
			throw StorageError.emptySession("We have an empty session")
		}
	}
	
	public func writeUserSession(userSession: UserSession) -> AnyPublisher<UserSession, StorageError> {
		Future<UserSession, StorageError> { promise in
			DispatchQueue.global().async {
				if let data = try? JSONEncoder().encode(userSession) {
					self.db.set(data, forKey: Constants.Storage.userSession)
					return promise(.success(userSession))
				}
				return promise(.failure(StorageError.encodeError))
			}
		}.eraseToAnyPublisher()
	}
}
