//
//  UnsplashPhotosAPI.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
import Combine
protocol PhotosAPI: RemoteAPI {
	func getPhotoList(page:Int, perPage:Int, orderBy: String) -> AnyPublisher<[UnsplashPhoto], UnsplashPhotoError>
}

class UnsplashPhotosAPI: PhotosAPI {
	
	let session: Transport
	let apiSession: AccessToken
	
	init(session: Transport, apiSession: AccessToken) {
		self.session = session
		self.apiSession = apiSession
	}
	
	func getPhotoList(page:Int, perPage:Int, orderBy: String) -> AnyPublisher<[UnsplashPhoto], UnsplashPhotoError> {
		let endPoint = UnsplashPhotosEndPoint.photos(page, perPage, orderBy, apiSession)
		return self.fetch(endpoint: endPoint)
			.mapError({ networkError in
				return UnsplashPhotoError.networkError
			})
			.eraseToAnyPublisher()
	}
	
	func fetch<Element:Decodable >(endpoint: Endpoint) -> AnyPublisher<Element, NetworkError> {
		session.fetch(endpoint.request)
			.decode(type: Element.self, decoder: JSONDecoder())
			.mapError({_ in NetworkError.unknown})
			.eraseToAnyPublisher()
	}
}
