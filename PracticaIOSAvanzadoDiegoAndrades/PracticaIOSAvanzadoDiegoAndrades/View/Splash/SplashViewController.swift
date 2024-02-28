//
//  ViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 23/2/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
        
    }
}

