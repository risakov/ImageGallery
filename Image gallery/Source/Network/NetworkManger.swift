//
//  NetworkManger.swift
//  Image gallery
//
//  Created by Narek Matosyan on 16.02.2023.
//

import Foundation
import Alamofire

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

fileprivate struct APIResponse: Codable {
    let results: [Post]
}

class NetworkManager {
    
    let accessKey = "bbc33cc9f86e189e1387e31a57dbd74a2dba4a5f4540f7a0dbcb599fd72f61f2"
    let endpoint = "https://api.unsplash.com/search/photos"
    
    static var shared = NetworkManager()
    
    private var images = NSCache<NSString, NSData>()
    
    let session: URLSession
    
    init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func getPosts(query: String, page: Int, completion: @escaping ([Post]?, Error?) -> (Void)) {
        let parameters: Parameters = [
            "query": query,
            "page": page
        ]
        let headers : HTTPHeaders = [
            "Authorization": "Client-ID \(accessKey)",
        ]
        
        AF.request(endpoint, method: .get, parameters: parameters, headers: headers).responseDecodable(of: APIResponse.self) { data in
            switch data.result {
            case .success(let response):
                completion(response.results, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
