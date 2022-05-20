//
//  NetworkLayer.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import Foundation
import Combine
protocol RemoteAPI {
	func fetch<Element: Codable>(endpoint: Endpoint) -> AnyPublisher<Element, NetworkError>
}

