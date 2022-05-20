//
//  HomeViewModel.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 25/04/22.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
	// MARK: Dependencies
	let photosRepository: PhotosRepositoryProtocol
	let imageLoader: ImageLoader
	// MARK: State
	@Published var homeFeedItems:[HomeFeedItem] = []
	private(set) var register = Set<(String,AnyCancellable)>()
	private(set) var subscriptions = Set<AnyCancellable>()
	
	init(photosRepository: PhotosRepositoryProtocol, imageLoader: ImageLoader){
		self.photosRepository = photosRepository
		self.imageLoader = imageLoader
	}
	
	// MARK: Task Methods
	func loadFeed(){
		self.photosRepository.getPhotos(page: 1, perPage: 20, orderBy: "latest")
			.receive(on: DispatchQueue.main)
			.sink { completion in
				AppLogger.shared.log(log: "PhotosRepo completed with:\(completion)")
			} receiveValue: { feedItem in
				self.homeFeedItems = feedItem
			}
			.store(in: &subscriptions)
	}
	
	func loadImage(homeFeedItem: HomeFeedItem){
		guard homeFeedItem.image == nil else {return}
		guard let url = URL(string: homeFeedItem.urls.raw) else { return }
		guard !self.register.contains(url.absoluteString) else {return}
		
		
		let subscription = self.imageLoader.loadImage(url: url)
			//.receive(on: DispatchQueue.main)
			.sink { completion in
				self.register.remove(url.absoluteString)
				print(completion)
			} receiveValue: { image in
				if let idx = self.homeFeedItems
								.firstIndex(where: {$0.id == homeFeedItem.id}) {
					DispatchQueue.main.async {
						self.homeFeedItems[idx].image = image
						print("------------Updated:\(idx)-imageSize:\(image.size)")
					}
					
				}
			}
		
		self.register.insert((url.absoluteString, subscription))
	}
	
	
}

