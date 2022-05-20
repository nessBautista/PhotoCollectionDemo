//
//  ImageLoader.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 26/04/22.
//

import Foundation
import Combine
import UIKit
protocol ImageLoader {
	
	func loadImage(url:URL) -> AnyPublisher<UIImage,NetworkError>
}

class HomeImageLoader: ImageLoader {
	var cache = NSCache<NSString, UIImage>()	
	var bytes:Int = 0{
		didSet{
			let bcf = ByteCountFormatter()
			bcf.allowedUnits = [.useMB]
			bcf.countStyle = .memory
			let megas = bcf.string(fromByteCount: Int64(bytes))
			print("Loaded: \(megas) GB")
		}
	}
	func loadImage(url: URL) -> AnyPublisher<UIImage, NetworkError> {
		
		if let image = cache.object(forKey: url.absoluteString as NSString) {
			return Future<UIImage, NetworkError>{ promise in
				return promise(.success(image))
			}
			.eraseToAnyPublisher()
		} else {
			return URLSession.shared.dataTaskPublisher(for: url)
				.receive(on: DispatchQueue.global(qos: .userInitiated))
				.map { (data, response) in
					guard let response = response as? HTTPURLResponse else {
						return UIImage()
					}
					guard response.statusCode == 200 else {return UIImage()}
					if let image = UIImage(data: data){
						self.bytes += data.count
						self.cache.setObject(image, forKey: url.absoluteString as NSString)
						return image
					}
					return UIImage()
				}
				.mapError({_ in NetworkError.unknown})
				.eraseToAnyPublisher()
		}
		
		
		
	}
}
