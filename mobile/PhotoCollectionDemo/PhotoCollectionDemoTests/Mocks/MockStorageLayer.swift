//
//  MockStorageLayer.swift
//  PhotoCollectionDemoTests
//
//  Created by Nestor Hernandez on 08/04/22.
//

import Combine
import Foundation
@testable import PhotoCollectionDemo
class MockStorageLayer: UserSessionDataStore{
	private(set) var subject = PassthroughSubject<Data?, StorageError>()
	private(set) var subjectWrite = PassthroughSubject<UserSession, StorageError>()
	
	func readUserSession() throws -> Data {
		return Data()
	}
	
	func writeUserSession(userSession: UserSession) -> AnyPublisher<UserSession, StorageError> {
		subjectWrite.eraseToAnyPublisher()
	}
	
	
	
	func readUserSession() -> AnyPublisher<Data?, StorageError> {
		subject.eraseToAnyPublisher()		
	}
	
	// Represents Receiving Mocking Responses
	func send(_ data: Data?){
		self.subject.send(data)
	}
}
