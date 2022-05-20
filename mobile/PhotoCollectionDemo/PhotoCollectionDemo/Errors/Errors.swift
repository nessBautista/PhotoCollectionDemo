//
//  Errors.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 06/04/22.
//

import Foundation
enum NetworkError: Error {
	case noDataResponse
	case loginError
	case urlSessionError(Int)
	case unknown
}

public enum StorageError: Error, Equatable{
	case emptySession(String)
	case encodeError
	case unknown
}

public enum UnsplashPhotoError: Error, Equatable {
	case networkError
	case decodingError
	case photoError(String)
}
