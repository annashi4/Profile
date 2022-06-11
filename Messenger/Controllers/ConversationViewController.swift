//
//  ViewController.swift
//  Messenger
//
//  Created by Anna on 10.06.2022.
//

import UIKit

class ConversationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "Logged In")
        
        if !isLoggedIn {
            let vc = LoginViewController()
            let navigationVC = UINavigationController(rootViewController: vc)
            navigationVC.modalPresentationStyle = .fullScreen
            
            present(navigationVC, animated: false)
        }
    }

}

