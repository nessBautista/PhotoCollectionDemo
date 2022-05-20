//
//  Transport.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 16/04/22.
//

import Foundation
import Combine

protocol Transport {
	// Abstract representation of the URLSession
	func fetch(_ request: URLRequest)-> AnyPublisher<Data, NetworkError>
}

extension URLSession: Transport {
	func fetch(_ request: URLRequest) -> AnyPublisher<Data, NetworkError> {		
		return self.dataTaskPublisher(for: request)
			.tryMap { data, response in
				guard let response = response as? HTTPURLResponse else {
					throw NetworkError.noDataResponse
				}
				guard response.statusCode == 200 else {
					throw NetworkError.urlSessionError(response.statusCode)
				}
				return data
			}
			.mapError { error in
				//TODO: Handle error
				return NetworkError.unknown
			}
			.eraseToAnyPublisher()
	}
}
