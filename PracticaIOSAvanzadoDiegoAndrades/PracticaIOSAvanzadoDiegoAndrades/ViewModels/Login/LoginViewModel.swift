//
//  LoginViewModel.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 26/2/24.
//

import Foundation

final class LoginViewModel {
    
    //Binding con UI
    var loginViewState: ((LoginStatusLoad) -> Void)?
    
    private let loginUseCase: LoginUseCaseProtocol
    
    //MARK: - Init
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()){
        self.loginUseCase = loginUseCase

    }
    
    // Método login
    func loginbutton(email: String?, password: String?){
        loginViewState?(.loading(true))
        
        // Compruebo el email y el password
        guard let email = email, isValid(email: email) else{
            loginViewState?(.loading(false))
            loginViewState?(.showErrorEmail("Error en el email"))
            return
        }
            
        guard let password = password, isValid(password: password) else {
            loginViewState?(.loading(false))
            loginViewState?(.showErrorPassWord("Error introduciendo password"))
            return
        }
        doLoginWith(email: email, password: password)
        
    }
    
    
    //check email y password
    
    private func isValid(email: String)->Bool{
        email.isEmpty == false && email.contains("@")
    }
    
    // Compruebo que el password tenga más de un dígito
    private func isValid(password: String)->Bool{
        password.isEmpty == false && password.count >= 1
        
    }
    
    
    private func doLoginWith(email: String, password: String){
        //TODO: Llamar al caso de USO
        loginUseCase.login(user: email, password: password) { [weak self] token in
            //Codigo por success
            DispatchQueue.main.async {
                self?.loginViewState?(.loaded)
            }
        } onError: {[weak self] networkError in
            DispatchQueue.main.async {
                var errorMessage = "Error desconocido"
                switch networkError{
                case .malformedURL:
                    errorMessage = "malformedURL"
                case .dataFormatting:
                    errorMessage = "dataFormatting"
                case .other:
                    errorMessage = "other"
                case .noData:
                    errorMessage = "noData"
                case .errorCode(let error):
                    errorMessage = "errorCode \(error?.description ?? "Unknown")"
                case .tokenFormatError:
                    errorMessage = "tokenFormatError"
                case .decoding:
                    errorMessage = "decoding"
                }
                self?.loginViewState?(.errorNetwork(errorMessage))
            }
        }
    }
}
