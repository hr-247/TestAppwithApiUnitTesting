//
//  MockNetworkManager.swift
//  TestableAppTests
//
//  Created by Harish . on 03/12/23.
//

import Foundation

@testable import TestableApp

class MockNetworkManager: NetworkManagerProtocol{
    
    private let result: Result<ResponseModel,NetworkError>
    
    init(result: Result<ResponseModel, NetworkError>) {
        self.result = result
    }
    
    func performRequest<T: Decodable>(urlString: String, completion: @escaping (Result<T, NetworkError>) -> Void) {
        completion(result as! Result<T, NetworkError>)
    }
    
    
}
