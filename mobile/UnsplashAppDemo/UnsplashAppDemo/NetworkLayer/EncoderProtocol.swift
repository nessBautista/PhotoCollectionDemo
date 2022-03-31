//
//  EncoderProtocol.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 26/02/22.
//

import Foundation
import OrderedCollections

enum EncoderType {
    case json
    case url
}

protocol EncoderProtocol {
	var request: URLRequest {get set}
    func encode(params: OrderedDictionary<String,Any>) throws
}

extension EncoderProtocol {
	@discardableResult func validateURL() throws -> URL  {
		guard let url = request.url else {
			throw NetworkError.decoderError(message: Constants.ErrorMessages.invalid_url)
		}
		return url
	}
}


