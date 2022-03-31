//
//  DemoErrors.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 22/03/22.
//

import Foundation
enum NetworkError: Error {
	case decoderError(message: String)
}
