//
//  MockUserResponse.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import Foundation
class MockUserResponse: UserSessionProtocol {
	var profile: UserProfile
		
	public var accessToken: AccessToken
	
	public init(accessToken: AccessToken, profile: UserProfile){
		self.accessToken = accessToken
		self.profile = profile
	}
	
	
}
