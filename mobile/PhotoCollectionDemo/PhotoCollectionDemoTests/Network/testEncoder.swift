//
//  testEncoder.swift
//  PhotoCollectionDemoTests
//
//  Created by Nestor Hernandez on 09/04/22.
//

import XCTest
@testable import PhotoCollectionDemo

class testEncoder: XCTestCase {
	var sut: EncoderType!
	var testParameters:[String: Any]!
	var testRequest: URLRequest!
		
    override func setUp() {
		super.setUp()
		givenTestParameters()
		givenTestRequest()
		givenURLEncoder()
    }

    override func tearDown() {
		testParameters = nil
		testRequest = nil
		sut = nil
		super.tearDown()
    }
	
	func givenURLEncoder(){
		sut = EncoderType.url
	}
	
	func givenJSONEncoder(){
		sut = EncoderType.json
	}
	
	func givenTestParameters(){
		testParameters = [:]
		testParameters["one"] = 1
		testParameters["two"] = 2
		testParameters["three"] = 3
	}
	
	func givenTestRequest() {
		let url = URL(string: "www.testURL.com")!
		testRequest = URLRequest(url: url)
	}
	

	func testURLEncoding(){
		givenURLEncoder()
		
		//when
		sut.encode(request: &testRequest, params: testParameters!)
		
		//then
		let components = testRequest.getQueryItems()
		XCTAssertNotNil(components)
	}
	
	func testJSONEncoding(){
		givenJSONEncoder()
		
		//when
		sut.encode(request: &testRequest, params: testParameters)
		
		// then
		XCTAssertNotNil(testRequest.httpBody)
	}
}
