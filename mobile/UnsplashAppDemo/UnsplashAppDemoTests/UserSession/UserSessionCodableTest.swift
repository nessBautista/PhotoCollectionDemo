//
//  UserSessionCodableTest.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 06/03/22.
//

import XCTest
@testable import UnsplashAppDemo


class UserSessionCodableTest: XCTestCase{
	let dependencyContainer: DependencyContainer = DependencyContainer()
	var sut: UserSessionCodable!
	var givenUnsplashURL: URL!
	var givenIncompleteUnsplashURL: URL!
	var unsplashAccessTokenData: Data?
	
	override func setUpWithError() throws {
		try! super.setUpWithError()
		sut = dependencyContainer.makeUserSessionCodable()
		givenUnsplashURL = URL(string: "https://unsplash.com/oauth/authorize/native?code=4I3dd5WjhXImcUAH2PpR5KJVqUMxSke6GevUf57QJH4")!
		givenIncompleteUnsplashURL = URL(string: "https://unsplash.com/oauth/authorize/native?code")!
	}
	
	override func tearDownWithError() throws {
		givenUnsplashURL = nil
		unsplashAccessTokenData = nil
		sut = nil
		try! super.tearDownWithError()
	}
	
	func givenAccessTokenDataResponse() {
		let bundle = Bundle(for: UserSessionCodableTest.self)
		let jsonAsset = NSDataAsset(name: "UnsplashAccessToken", bundle: bundle)
		self.unsplashAccessTokenData = jsonAsset?.data
	}
	
	func givenIncorrectAccessTokenDataResponse() {
		let bundle = Bundle(for: UserSessionCodableTest.self)
		let jsonAsset = NSDataAsset(name: "incorrectUnsplashAccessToken", bundle: bundle)
		self.unsplashAccessTokenData = jsonAsset?.data
	}
	
	func testUserSessionCodable_returns_AuthCodeFromURL(){
		// When
		let code = sut.getAuthorizationCode(from: givenUnsplashURL)
		// Then
		XCTAssertNotNil(code)
		XCTAssertNotNil(sut.authorizationCode)
	}
	
	func testUserSessionCodable_returnsNil_fromURLIncompleteURL(){
		// When
		let code = sut.getAuthorizationCode(from: givenIncompleteUnsplashURL)
		// Then
		XCTAssertNil(code)
		XCTAssertNil(sut.authorizationCode)
	}
	
	
	func testUserSessionCodable_returnsNil_WhenEmptyAccessTokenJsonResponse(){
		// given
		let nilAccessTokenData: Data? = nil
		// when
		//when
		let accessToken = sut.decodeAccessToken(data: nilAccessTokenData,
												model: UnsplashAccessTokenResponse.self)
		//then
		XCTAssertNil(accessToken)
	}
	
	func testUserSessionCodable_returnsNil_WhenDecodingDifferentModel(){
		// given
		givenIncorrectAccessTokenDataResponse()
		
		//when
		let accessToken = sut.decodeAccessToken(data: unsplashAccessTokenData,
												model: UnsplashAccessTokenResponse.self)
		//then
		XCTAssertNil(accessToken)
	}
	
	func testUserSessionCodable_decodes_AccessTokenJsonResponse(){
		// given
		givenAccessTokenDataResponse()
		
		//when
		let accessToken = sut.decodeAccessToken(data: unsplashAccessTokenData,
												model: UnsplashAccessTokenResponse.self)
		//then
		XCTAssertNotNil(accessToken)
		// JSON values from Unsplash Documentation
		XCTAssertEqual(accessToken?.token_type, "bearer")
		XCTAssertEqual(accessToken?.scope, "public read_photos write_photos")
		XCTAssertEqual(accessToken?.created_at, 1436544465)
		XCTAssertEqual(accessToken?.access_token,
					   "091343ce13c8ae780065ecb3b13dc903475dd22cb78a05503c2e0c69c5e98044")
	}
	
	func testUserSessionCodable_makes_EmptyUserSessionFromEmtpyData(){
		// given a valid accessToken Response
		let emptyAccessTokenData: Data? = nil
		
		// when accessTokenResponse is decoded
		_ = sut.decodeAccessToken(data: emptyAccessTokenData,
											 model: UnsplashAccessTokenResponse.self)
		
		// then a valid UserSession can be created
		let userSession = sut.makeUserSession()
		XCTAssertNil(userSession)
	}
	
	func testUserSessionCodable_makes_UserSession(){
		// given a valid accessToken Response
		givenAccessTokenDataResponse()
		
		// when accessTokenResponse is decoded
		_ = sut.decodeAccessToken(data: unsplashAccessTokenData,
											 model: UnsplashAccessTokenResponse.self)
		
		// then a valid UserSession can be created
		let userSession = sut.makeUserSession()
		XCTAssertNotNil(userSession)
	}
	
	func testUserSessionCodable_createsUserSession_from_DataResponse(){
		// given
		givenAccessTokenDataResponse()
		// When
		let userSession = sut.makeUserSession(data: unsplashAccessTokenData,
							model: UnsplashAccessTokenResponse.self)
		// Then
		XCTAssertTrue((userSession as AnyObject) is UserSession)
	}
}


