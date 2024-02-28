//
//  ViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 23/2/24.
//

import UIKit

class SplashViewController: UIViewController {
    
    private var secureData: SecureDataProtocol
    
    init(secuteData: SecureDataProtocol = SecureData()){
        self.secureData = secuteData
        super.init(nibName: String(describing:SplashViewController.self), bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var destination : UIViewController
        
        if let token = secureData.getToken() {
            destination = HeroesListViewController()
        }else{
            destination = LoginViewController()
        }

        let loginVC = LoginViewController()
        navigationController?.setViewControllers([destination], animated: true)
        
    }
}

