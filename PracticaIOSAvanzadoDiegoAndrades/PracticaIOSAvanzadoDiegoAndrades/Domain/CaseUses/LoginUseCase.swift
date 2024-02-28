//
//  LoginUseCase.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 28/2/24.
//

import Foundation

protocol LoginUseCaseProtocol {
    
    func login(user: String,
               password: String,
               onSuccess: @escaping(String?) -> Void,
               onError: @escaping(NetworkError) -> Void)
}


final class LoginUseCase: LoginUseCaseProtocol {
    
    private var secureData: SecureDataProtocol
    init(secureData: SecureDataProtocol = SecureData()) {
        self.secureData = secureData
    }
    
   
    func login(user: String,
               password: String,
               onSuccess: @escaping(String?) -> Void,
               onError: @escaping(NetworkError) -> Void){
        
        //Compruebo la URL
        guard let url = URL(string: "\(EndPoints.url.rawValue)\(EndPoints.login.rawValue)") else {
            onError(.malformedURL)
            return
        }
        
        
        // Codifico los datos
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else {
            onError(.dataFormatting)
            return
        }
        
        let base64LoginString = loginData.base64EncodedString()
        
        //Creo Request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPMethods.post
        urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        //DataTask
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response, error  in
            guard error == nil else {
                onError(.other)
                return
            }
            guard let data = data else {
                onError(.noData)
                return
            }
            
            guard let httpResponse = (response as? HTTPURLResponse) else {
                return
            }
            
            guard  httpResponse.statusCode == HTTPResponseCodes.SUCCESS else {
                onError(.errorCode((response as? HTTPURLResponse)?.statusCode))
                return
            }
            
            // TRANSFORMO EL DATO PARA TENER EL TOKEN
            
            guard let token  = String(data: data, encoding: .utf8) else {
                onError(.tokenFormatError)
                return
            }
            
            self?.secureData.setToken(value: token)
            onSuccess(token)
        }
        task.resume()
    }
    
    
}
