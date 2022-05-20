//
//  Photos.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
struct UnsplashPhoto: Codable, Identifiable {
	var id: String
	var description: String?
	var created_at: String
	var updated_at: String
	var urls:UnsplashPhotoURLs
}

struct UnsplashPhotoURLs: Codable {
	var raw: String
	var full: String
	var regular: String
	var small: String
	var thumb: String
}
