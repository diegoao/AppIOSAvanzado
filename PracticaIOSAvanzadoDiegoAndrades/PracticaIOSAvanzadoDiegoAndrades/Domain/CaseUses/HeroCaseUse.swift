//
//  HeroCaseUse.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//

import Foundation


final class HeroCaseUse {
    
    private var secureData: SecureDataProtocol
    init(secureData: SecureDataProtocol = SecureData()) {
        self.secureData = secureData
    }
    
    func logout() -> Bool { 
        let tokenEliminado = self.secureData.deleteToken()
        return tokenEliminado
    }
    
    
}

