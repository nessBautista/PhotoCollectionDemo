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
    func encode(params: OrderedDictionary<String,Any>)
}
