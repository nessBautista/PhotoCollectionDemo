//
//  MockAuthUserSessionRepo.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 09/03/22.
//

import Foundation
import Combine

@testable import UnsplashAppDemo

class MockUnsplashNetworkLayer: NetworkLayer {
	private(set) var subject = PassthroughSubject<Data?, Error>()
	
	func fetch(_ params:[String: Any]?) -> AnyPublisher<Data?, Error>{
		subject.eraseToAnyPublisher()
	}
	
	// Testing
	func send(data: Data?){
		self.subject.send(data)
	}
}
