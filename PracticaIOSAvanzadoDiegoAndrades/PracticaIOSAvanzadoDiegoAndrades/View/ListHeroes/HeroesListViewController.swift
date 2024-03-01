//
//  HeroesListViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 26/2/24.
//

import UIKit

class HeroesListViewController: UIViewController {
    
    @IBOutlet weak var buttonLogout: UIButton!
    
    
    init(viewModel: HeroViewModel = HeroViewModel()){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private var viewModel: HeroViewModel
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Función para eliminar el token
    @IBAction func ButtonLogout(_ sender: Any) {
        let borradoDatos = viewModel.deleteData()
        if borradoDatos{
            let loginVC = LoginViewController()
            navigationController?.setViewControllers([loginVC], animated: true)
        }
    }
}
    
