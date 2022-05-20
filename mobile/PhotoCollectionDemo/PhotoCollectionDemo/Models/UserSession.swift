//
//  UserSession.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import Foundation
public protocol UserSessionProtocol: Codable {
	var accessToken: AccessToken {get}
	var profile: UserProfile {get} 
}

public struct UserSession: Codable, Equatable {
	public static func == (lhs: UserSession, rhs: UserSession) -> Bool {
		lhs.accessToken.access_token != rhs.accessToken.access_token
	}
	
	public var accessToken: AccessToken
	var profile: UserProfile
	
	public init(accessToken: AccessToken, profile: UserProfile) {
		self.accessToken = accessToken
		self.profile = profile
	}
}
