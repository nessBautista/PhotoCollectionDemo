//
//  RemoteAPI.swift
//  PhotoCollectionDemo
//
//  Created by Nestor Hernandez on 15/04/22.
//

import Foundation
protocol Endpoint {
	var baseURL: URL {get}
	var endPoint: String { get }
	var request:URLRequest { get }
	var encoder: EncoderType { get }
	var parameters: [String: Any] {get}
	var headers: [String:String] {get}
}

