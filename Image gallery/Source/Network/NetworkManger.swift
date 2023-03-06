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
    
    func posts(query: String, completion: @escaping ([Post]?, Error?) -> (Void)) {
        let parameters: Parameters = [
            "query": query
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
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
            print("using cached images")
            completion(imageData as Data, nil)
            return
        }
        
        let task = session.downloadTask(with: imageURL) { localUrl, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(nil, NetworkManagerError.badResponse(response))
                return
            }
            
            guard let localUrl = localUrl else {
                completion(nil, NetworkManagerError.badLocalUrl)
                return
            }
            
            do {
                let data = try Data(contentsOf: localUrl)
                self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        
        task.resume()
    }
    
    func image(post: Post, completion: @escaping (Data?, Error?) -> (Void)) {
        let url = URL(string: post.urls.regular)!
        download(imageURL: url, completion: completion)
    }
}
