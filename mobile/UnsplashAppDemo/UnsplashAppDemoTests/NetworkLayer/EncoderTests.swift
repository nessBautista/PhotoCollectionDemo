//
//  URLEncoderTests.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 26/02/22.
//

import XCTest
@testable import UnsplashAppDemo
import OrderedCollections

class EncoderTests: XCTestCase {
    var sut: EncoderProtocol!
    let string_baseURL = "https://someAPI.com/someEndPoint/"
	var urlRequest: URLRequest!
    
	override func setUpWithError() throws {
        try super.setUpWithError()
        let url = URL(string: string_baseURL)!
		urlRequest = URLRequest(url: url)
    }

    override func tearDownWithError() throws {
		urlRequest = nil
        sut = nil
        try super.tearDownWithError()
    }
	
	func givenURLEncoder(){
		sut = URLRequestEncoder(request: urlRequest)
	}
	func givenJSONEncoder(){
		sut = JSONRequestEncoder(request: urlRequest)
	}

    // MARK: Init
    func testURLEncoder_Init(){
        givenURLEncoder()
        XCTAssertNotNil(sut.request.url?.absoluteString)
    }
	func testJSONEncoder_Init(){
		givenJSONEncoder()
		XCTAssertNotNil(sut.request.url?.absoluteString)
	}
    
    // MARK: Encoding
    func testURLEncoder_receivesParametersDictionary_outputsURLWithParameters(){
        // given
		givenURLEncoder()
        let parameters: OrderedDictionary<String, Any> = ["param1": 1, "param2":2]
        
        // When encoding
		XCTAssertNoThrow(try sut.encode(params: parameters))
        
        
        // then
        XCTAssertTrue(TestUtilities.very(request: sut.request, contains: parameters))
    }
	
	func testJSONEncoder_inputParameters_areEncodedInHTTPBody(){
		// given
		givenJSONEncoder()
		let parameters: OrderedDictionary<String, Any> = ["param1": 1, "param2":2]
		// When encoding
		XCTAssertNoThrow(try sut.encode(params: parameters))
		// then
		XCTAssertTrue(TestUtilities.verifyHTTPBody(request: sut.request, contains: parameters))
		
	}
	
	func testURLEncoder_throwsError_forInvalidURL(){
		//given
		urlRequest.url = nil
		givenURLEncoder()		
		let parameters: OrderedDictionary<String, Any> = ["param1": 1, "param2":2]
		// when
		XCTAssertThrowsError(try sut.encode(params: parameters))
	}
	
	func testJSONEncoder_throwsError_forInvalidURL(){
		//given
		urlRequest.url = nil
		givenJSONEncoder()
		let parameters: OrderedDictionary<String, Any> = ["param1": 1, "param2":2]
		// when
		XCTAssertThrowsError(try sut.encode(params: parameters))
	}
	
}
