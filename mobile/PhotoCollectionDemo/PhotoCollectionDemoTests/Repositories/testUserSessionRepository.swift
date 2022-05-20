//
//  testUserSessionRepository.swift
//  PhotoCollectionDemoTests
//
//  Created by Nestor Hernandez on 06/04/22.
//

import XCTest
import Combine
@testable import PhotoCollectionDemo

class testUserSessionRepository: XCTestCase {
	var subscriptions = Set<AnyCancellable>()
	var mockNetwork: MockNetworkLayer?
	var mockStorageLayer: MockStorageLayer?
	var sut:UserSessionRepositoryProtocol?
	
    override func setUpWithError() throws {
		try super.setUpWithError()
		mockNetwork = MockNetworkLayer()
		mockStorageLayer = MockStorageLayer()
		sut = UserSessionRepository(networkLayer: mockNetwork!, storageLayer: mockStorageLayer!)
    }

    override func tearDownWithError() throws {
		mockNetwork = nil
        sut = nil
		try super.tearDownWithError()
    }

	func testStorageRespondeWithEmptyData() {
		// Given
		let exp = expectation(description: "Empty Data throws noDataResponse")
		let expectedError = StorageError.emptySession("")
		var receivedError = StorageError.unknown
		
		sut?.readUserSession().sink(receiveCompletion: { completion in
			if case .failure(let error) = completion {
				receivedError = error
				exp.fulfill()
			}
		}, receiveValue: { userSession in
			print(userSession)
		}).store(in: &subscriptions)
		
		// When
		mockStorageLayer?.send(nil)
		
		//then
		wait(for: [exp], timeout: 0.1)
		XCTAssertEqual(receivedError, expectedError)
	}

}
