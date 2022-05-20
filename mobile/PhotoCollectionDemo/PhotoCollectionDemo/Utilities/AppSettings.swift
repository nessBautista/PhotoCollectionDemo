//
//  AppSettingsStorage.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 24/04/22.
//

import Foundation
//TODO: Reads from info.plist and other formats
protocol AppSettingsProtocol {
	var apiSettings: APISettings {get}
}

struct APISettings: Codable {
	let clientId: String
	let clientSecret: String
	let redirect: String
	let basicAccess: String
	
	init(clientId: String = String(),
		 clientSecret: String = String(),
		 redirect: String = String(),
		 basicAccess:String = String()){
		self.clientId = clientId
		self.clientSecret = clientSecret
		self.redirect = redirect
		self.basicAccess = basicAccess
	}
}

class AppSettings: AppSettingsProtocol {
	let plistReader:PlistReaderProtocol
	let apiSettings: APISettings
	
	init(plistReader:PlistReaderProtocol) {
		self.plistReader = plistReader
		
		if let unsplashApiConfig = plistReader.getValue(for: "UnsplashAPI"),
		let basicAccess = unsplashApiConfig["basicAccess"] as? String,
		let redirect = unsplashApiConfig["redirect"] as? String,
		let clientSecret = unsplashApiConfig["clientSecret"] as? String,
		let clientId = unsplashApiConfig["clientId"] as? String {
			apiSettings = APISettings(clientId: clientId,
									  clientSecret: clientSecret,
									  redirect: redirect,
									  basicAccess: basicAccess)
		} else {
			apiSettings = APISettings()
		}
	}
}
