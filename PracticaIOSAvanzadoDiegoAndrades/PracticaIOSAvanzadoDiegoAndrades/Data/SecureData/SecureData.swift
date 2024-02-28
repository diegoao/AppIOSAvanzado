//
//  SecureData.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 28/2/24.
//

import Foundation

// Importamos la librería que hmos añadido
import KeychainSwift

protocol SecureDataProtocol {
    func setToken(value: String)
    func getToken()-> String?
    func deleteToken()
}


class SecureData: SecureDataProtocol {
    
    private let keychain = KeychainSwift()
    private let keyToken = "keyToken"
    
    // FUNCION PARA GUARDAR EL TOKEN
    func setToken(value: String){
        keychain.set(value, forKey: keyToken)
        
    }
    // FUNCION PARA LEER EL TOKEN
    func getToken()-> String?{
        keychain.get(keyToken)
    }
    
    // FUNCION PARA ELIMINAR EL TOKEN
    func deleteToken(){
        
        keychain.delete(keyToken)
        
    }
    
    
}
