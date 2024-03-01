//
//  HeroViewModel.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//

import Foundation


final class HeroViewModel {
    
    let heroCaseUse = HeroCaseUse()
    
    func deleteData()-> Bool{
       let eliminado = heroCaseUse.logout()
        return eliminado
    }
}
