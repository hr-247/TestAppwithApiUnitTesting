//
//  NetworkManager.swift
//  TestableApp
//
//  Created by Harish . on 02/12/23.
//

import Foundation


protocol NetworkManagerProtocol: AnyObject{
    func performRequest<T: Codable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void)
}

enum NetworkError: Error, Equatable{
    case invalidUrl
    case requestFailed(Error)
    
    // Implementing the Equatable protocol
        static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
            switch (lhs, rhs) {
            case (.invalidUrl, .invalidUrl):
                return true
            case let (.requestFailed(lhsError), .requestFailed(rhsError)):
                // Compare underlying errors, you may need to adjust this based on your requirements
                return (lhsError as NSError) == (rhsError as NSError)
            default:
                return false
            }
        }
}

class NetworkManager: NetworkManagerProtocol{
    func performRequest<T: Codable>(urlString: String, completion: @escaping (Result<T,NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response , error in
            
            if let error = error {
                completion(.failure(.requestFailed(error)))
            }
            
            guard let data = data else {return}
            
            do{
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                
            }catch{
                completion(.failure(.requestFailed(error)))
            }
            
        }.resume()
    }
    
    
}
