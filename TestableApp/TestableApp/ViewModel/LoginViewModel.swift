//
//  LoginViewModel.swift
//  TestableApp
//
//  Created by Harish . on 02/12/23.
//

import Foundation



final class DefaultLoginViewModel{
    
    private let networkManager : NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func loginUser(userName: String, password: String, completion: @escaping (Result<ResponseModel,Error>)->Void){
        
        let urlString = "https://example.com/login?username=\(userName)&password=\(password)"
        
        networkManager.performRequest(urlString: urlString, completion: { (result: Result<ResponseModel,NetworkError>) in
            
            switch result {
                
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
            
        })
        
    }
    
}
