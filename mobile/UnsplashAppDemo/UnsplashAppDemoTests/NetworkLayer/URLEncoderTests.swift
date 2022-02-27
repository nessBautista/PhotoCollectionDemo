//
//  URLEncoderTests.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 26/02/22.
//

import XCTest
@testable import UnsplashAppDemo
@testable import OrderedCollections

class URLEncoderTests: XCTestCase {
    var sut: RequestEnconder!
    let string_baseURL = "https://someAPI.com/someEndPoint/"
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        let url = URL(string: string_baseURL)!
        let urlRequest = URLRequest(url: url)
        sut = RequestEnconder(type: .url, request: urlRequest)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    // MARK: Init
    func testInit_receives_EncoderType_and_URLRequest(){
        XCTAssertEqual(sut.requestType, .url)
        XCTAssertNotNil(sut.request.url?.absoluteString)
    }
    
    // MARK: Encoding
    func test_encodeFunction_receivesParametersDictionary_outputsURLWithParameters(){
        // given
        let parameters: OrderedDictionary<String, Any> = ["param1": 1, "param2":2]
        
        // When encoding
        sut.encode(params: parameters)
        
        // then
        XCTAssertTrue(TestUtilities.very(request: sut.request, contains: parameters))
    }
}
