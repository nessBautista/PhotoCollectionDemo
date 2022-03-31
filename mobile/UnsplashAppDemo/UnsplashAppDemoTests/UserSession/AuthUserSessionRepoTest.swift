//
//  AuthUserSessionRepoTest.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 06/03/22.
//

import XCTest
@testable import UnsplashAppDemo
import Combine

class AuthUserSessionRepoTest: XCTestCase {
	var container: DependencyContainer!
	var sut:AuthUserSessionRepo!
	var subscriptions = Set<AnyCancellable>()
	var unsplashAccessTokenData: Data?
	
    override func setUpWithError() throws {
		try! super.setUpWithError()
		container = DependencyContainer()
		sut = container.makeAuthUserSessionRepo()
    }

    override func tearDownWithError() throws {
		container = nil
		sut = nil
		unsplashAccessTokenData = nil
		try! super.tearDownWithError()
	}

	func givenAccessTokenDataResponse() {
		let bundle = Bundle(for: UserSessionCodableTest.self)
		let jsonAsset = NSDataAsset(name: "UnsplashAccessToken", bundle: bundle)
		self.unsplashAccessTokenData = jsonAsset?.data
	}
	
	func test_fetchUserSession_returns_Publisher(){
		let publisher = sut.fetchUserSession()
		XCTAssertTrue((publisher as AnyObject) is AnyPublisher<UserSession?, Error>)
	}
	
	
	func test_fetchUserSession_returns_UserSession(){
		//given
		givenAccessTokenDataResponse()
		var sessionReceived: UserSession? = nil
		let mockUnsplashNetworkLayer = MockUnsplashNetworkLayer()
		sut.networkLayer = mockUnsplashNetworkLayer
		let expectation = expectation(description: "FetchUserSession returns a UserSession")
		sut.fetchUserSession().sink { completion in
			print(completion)
		} receiveValue: { session in
			sessionReceived = session
			expectation.fulfill()
		}.store(in: &subscriptions)
		
		//When
		mockUnsplashNetworkLayer.send(data: unsplashAccessTokenData)
		wait(for: [expectation], timeout: 1)
		
		//then
		XCTAssertNotNil(sessionReceived)
		XCTAssertNotNil(sessionReceived?.accessToken)
	}
	
	func test_fetchUserSession_givenNilData_returnsNilSession(){
		//given
		let mockUnsplashNetworkLayer = MockUnsplashNetworkLayer()
		sut.networkLayer = mockUnsplashNetworkLayer
		var sessionReceived:UserSession?
		let expectation = expectation(description: "FetchUserSession with empty Data returns an empty UserSession")
		sut.fetchUserSession().sink { completion in
			print(completion)
		} receiveValue: { session in
			sessionReceived = session
			expectation.fulfill()
		}.store(in: &subscriptions)
		
		//When
		mockUnsplashNetworkLayer.send(data: nil)
		wait(for: [expectation], timeout: 1)
		
		//then
		XCTAssertNil(sessionReceived)		
	}
	
}
