//
//  MockUserSession.swift
//  UnsplashAppDemoTests
//
//  Created by Nestor Hernandez on 09/03/22.
//

import Foundation
import XCTest
@testable import UnsplashAppDemo

class MockUserSession: UserSession {
	var accessToken: String
		
	init(accessTokenResponse: AccessTokenResponse = MockAccessTokenResponse()) {	
		self.accessToken = accessTokenResponse.access_token
	}
}

class MockAccessTokenResponse: AccessTokenResponse {
	var access_token: String = "091343ce13c8ae780065ecb3b13dc903475dd22cb78a05503c2e0c69c5e98044"
	
	var token_type: String = "bearer"
	
	var scope: String = "public read_photos write_photos"
	
	var created_at: Double = 1436544465
}
