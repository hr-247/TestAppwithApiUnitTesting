//
//  ViewController.swift
//  TestableApp
//
//  Created by Harish . on 02/12/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    //IBOutlets
    
    
    private let viewModel: DefaultLoginViewModel? = DefaultLoginViewModel()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel?.loginUser(userName: "Harish", password: "12345", completion: { [weak self] result in
            //perform your task
            debugPrint(result)
        })
        
    }


}

