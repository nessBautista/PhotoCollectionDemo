//
//  NetworkLayerProtocol.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 26/02/22.
//

import Foundation
import Combine

protocol NetworkLayer {
	func fetch(_ params:[String: Any]?) -> AnyPublisher<Data?, Error>
}
