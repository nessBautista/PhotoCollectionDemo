//
//  PhotosRepository.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
import Combine

protocol PhotosRepositoryProtocol {
	func getPhotos(page:Int, perPage:Int, orderBy: String)-> AnyPublisher<[HomeFeedItem], UnsplashPhotoError>
}

class PhotosRepository: PhotosRepositoryProtocol {
	let photosAPI: PhotosAPI
	init(photosAPI: PhotosAPI){
		self.photosAPI = photosAPI
	}
	
	func getPhotos(page:Int,
				   perPage:Int,
				   orderBy: String)
					-> AnyPublisher<[HomeFeedItem], UnsplashPhotoError> {
						self.photosAPI.getPhotoList(page: page,
													perPage: perPage,
													orderBy: orderBy)
							.map { photos in
								return photos.map({HomeFeedItem(unsplashPhoto: $0)})
							}.eraseToAnyPublisher()
	}
}
