//
//  TestableAppTests.swift
//  TestableAppTests
//
//  Created by Harish . on 02/12/23.
//

import XCTest
@testable import TestableApp

final class TestableAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLoginUserSuccess(){
        
        let networkManger = MockNetworkManager(result: .success(ResponseModel(id: "1", name: "Harish")))
        let viewModel = DefaultLoginViewModel(networkManager: networkManger)
        let expectation = XCTestExpectation(description: "Login success")
        
        viewModel.loginUser(userName: "harish", password: "12345") { result in
            switch result{
            case .success(let response):
                let res = ResponseModel(id: "1", name: "Harish")
                XCTAssertEqual(response, res)
                expectation.fulfill()
            case .failure(_):
                XCTFail("Expected login success")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testLoginUserFailure(){
        
        let networkManager = MockNetworkManager(result: .failure(.invalidUrl))
        let viewModel = DefaultLoginViewModel(networkManager: networkManager)
        let expectation = XCTestExpectation(description: "Login failed")
        
        viewModel.loginUser(userName: "harish", password: "12345") { result in
            switch result{
            case .success(_):
                XCTFail("Expected login failure")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, .invalidUrl)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
        
    }
    
    


}
