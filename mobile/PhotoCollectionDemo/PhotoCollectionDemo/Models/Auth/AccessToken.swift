//
//  AccessToken.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 15/04/22.
//

import Foundation

public struct AccessToken: Codable {
	public var access_token: String
	public var token_type: String
	public var scope: String
	public var created_at: Int
}
