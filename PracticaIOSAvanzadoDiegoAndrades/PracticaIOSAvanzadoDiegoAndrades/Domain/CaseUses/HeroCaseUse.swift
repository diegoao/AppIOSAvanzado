//
//  HeroCaseUse.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//

import Foundation

protocol heroCaseUseProtocol{
    func logout() -> Bool
    func loadData()
    
}


final class HeroCaseUse {
    
    private var secureData: SecureDataProtocol
    private var apiProvider: ApiProvider
    private var storeDataProvider: StoreDataProviderProtocol
    
    
    init(secureData: SecureDataProtocol = SecureData(),
         apiProvider: ApiProvider = ApiProvider(),
         storeDataProvider: StoreDataProviderProtocol) {
        self.secureData = secureData
        self.apiProvider = apiProvider
        self.storeDataProvider = storeDataProvider
    }
    
    func logout() -> Bool { 
        let tokenEliminado = self.secureData.deleteToken()
        return tokenEliminado
    }
    
    func loadData() {
        
        if storeDataProvider.countHeroes() == 0 {
            apiProvider.getHero{ [weak self] result in
                switch result {
                case .success(let heroes):
                    DispatchQueue.main.async {
                        self?.storeDataProvider.insert(heroes: heroes)
                        self?.mapDataToHeroCellModel()
                    }
                case .failure(let error):
                    print("Error obteniendo datos \(error)")
                    //                    DispathQueue.main.async {
                    //                        self?.stateUpdated?(.error(error))
                    
                }
            }
        }
    }
        
    private func mapDataToHeroCellModel(filter: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil) {
        let heroes = self.storeDataProvider.fetchHeroes(filter: filter, sorting: sorting)

    }
    
    
    
    
    
}

