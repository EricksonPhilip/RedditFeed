//
//  Service.swift
//  RedditFeed
//
//  Created by Erickson Philip Rathina Pandi on 9/10/21.
//

import Foundation

enum RequestError: Error {
    case serverError
    case noData
    case dataDecodingError
}

enum RequestType: String {
    case get = "GET"
}

class NetworkService {
    
    func get(urlString: String,
             completion: @escaping (Result<RedditFeed, RequestError>) -> ()) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        var reqURL = URLRequest(url: url)
        reqURL.httpMethod = RequestType.get.rawValue
        
        let task = URLSession.shared.dataTask(with: reqURL) { responseData, response, error in
            
            guard let data = responseData , error == nil else {
                print(error?.localizedDescription as Any)
                completion(.failure(.noData))
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse,
                    httpStatus.statusCode != 200 {
                completion(.failure(.serverError))
            }
            
            do {
                let decoder = JSONDecoder()
                let decodeModel = try decoder.decode(RedditFeed.self, from: data)
                completion(.success(decodeModel))
            }
            catch(let err) {
                print(err)
                completion(.failure(.dataDecodingError))
            }
        }
        
        task.resume()
        
    }
}
