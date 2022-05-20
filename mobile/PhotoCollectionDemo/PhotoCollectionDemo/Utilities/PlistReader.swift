//
//  PlistReader.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 24/04/22.
//

import Foundation

protocol PlistReaderProtocol {
	var fileName: String {get set}
	func getValue(for key: String) -> NSDictionary?
}

class APIConfigPlistReader: PlistReaderProtocol {
	var fileName: String
	init(fileName: String){
		self.fileName = fileName
	}
	
	func getValue(for key: String) -> NSDictionary? {
		if let path = Bundle.main.path(forResource: self.fileName, ofType: ".plist"),
		let dict = NSDictionary(contentsOfFile: path) {
			return dict[key] as? NSDictionary
		}
		return nil
	}
}
