//
//  HomeFeedItem.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 26/04/22.
//

import Foundation
import UIKit
struct HomeFeedItem: Identifiable {
	let id: String
	var title: String
	var rawImage: Data?
	var image: UIImage?
	let urls:UnsplashPhotoURLs
	
	init(unsplashPhoto: UnsplashPhoto){
		self.id = unsplashPhoto.id
		self.title = unsplashPhoto.description ?? "No title"
		self.urls = unsplashPhoto.urls
	}
}
