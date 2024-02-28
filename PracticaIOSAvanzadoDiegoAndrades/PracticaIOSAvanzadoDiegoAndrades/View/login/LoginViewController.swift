//
//  LoginViewController.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 26/2/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var errorEmail: UILabel!
    @IBOutlet weak var errorPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    private var viewModel: LoginViewModel
    
    
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorEmail.isHidden = true
        errorPassword.isHidden = true
        loadingView.isHidden = true
        setObservers()
    }

    
    
    @IBAction func buttonLoggin(_ sender: Any) {
        viewModel.loginbutton(email: emailText.text, password: passwordText.text)
    }
    
    

}


extension LoginViewController {
    // Metodo para "escuchar" variable de estado del viewModel
    private func setObservers() {
        viewModel.loginViewState = { [weak self] status in
            switch status {
                
            case .loading(let isLoading):
                self?.loadingView.isHidden = !isLoading
                
            case .loaded:
                self?.loadingView.isHidden = true
                self?.navigateToHome()
                
            case .showErrorEmail(let error):
                self?.errorEmail.text = error
                self?.errorEmail.isHidden = (error == nil || error?.isEmpty == true)
                
            case .showErrorPassWord(let error):
                self?.errorPassword.text = error
                self?.errorPassword.isHidden = (error == nil || error?.isEmpty == true)
            case .errorNetwork(let errorMessage):
                self?.loadingView.isHidden = true
                self?.showAlert(message: errorMessage)
            }
        }
    }
    
    private func navigateToHome() {
        let listHeroes = HeroesListViewController()
        navigationController?.setViewControllers([listHeroes], animated: true)
        
    }
    
    //MARK: - Alert
    private func showAlert(message: String){
        let alertControler = UIAlertController(title: "ERROR NETWORK", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
        alertControler.addAction(okAction)
        present(alertControler, animated: true, completion: nil)
    }
}

