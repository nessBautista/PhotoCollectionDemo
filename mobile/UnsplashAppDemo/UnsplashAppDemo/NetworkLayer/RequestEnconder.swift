//
//  Encoder.swift
//  UnsplashAppDemo
//
//  Created by Nestor Hernandez on 26/02/22.
//

import Foundation
import OrderedCollections
class RequestEnconder: EncoderProtocol {
    let requestType: EncoderType
    var request: URLRequest
    
    init(type: EncoderType, request: URLRequest){
        self.requestType  = type
        self.request = request
        
    }
    
    func encode(params: OrderedDictionary<String,Any>) {
        guard let url = request.url else { return }
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false){
            urlComponents.queryItems = []
            for (key, value) in params {
                let queryItem = URLQueryItem(name: key, value: "\(value)"
                                                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
                urlComponents.queryItems?.append(queryItem)
            }
            self.request.url = urlComponents.url
        }
        
    }
}
