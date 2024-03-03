//
//  DetailViewModel.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 3/3/24.
//

import Foundation
import CoreData

protocol DetailViewModelProtocol {

    func loadData()
}


final class DetailViewModel: DetailViewModelProtocol {
    private var heroess: [NSMHero] = []
    private var secureData: SecureDataProtocol
    private var apiProvider: ApiProvider
    private var storeDataProvider: StoreDataProviderProtocol

    init(secureData: SecureDataProtocol = SecureData(),
         apiProvider: ApiProvider = ApiProvider(),
         storeDataProvider: StoreDataProviderProtocol = StoreDataProvider()) {
        self.secureData = secureData
        self.apiProvider = apiProvider
        self.storeDataProvider = storeDataProvider
    }
    
    
    
    
}


extension DetailViewModel {

    func loadData() {
        heroess = storeDataProvider.fetchHeroes(filter: nil, sorting: self.sortDescriptor(ascending: false))
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
                }
            }
        }else{
            //notifyDataUpdated()
            mapDataToHeroCellModel()
        }
    }
    
    private func mapDataToHeroCellModel(filter: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil){
     let heroes = self.storeDataProvider.fetchHeroes(filter: filter, sorting: sorting)
        print(heroes)
    }
    

    func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.mapDataToHeroCellModel()
        }
    }
    
    func numOfHero() -> Int {
        return heroess.count
    }
    
    
    func nameForHero(indexPath: IndexPath) -> String? {
        return HeroAt(indexPath: indexPath)?.name
    }
    
    
    func HeroAt(indexPath: IndexPath) -> NSMHero? {
        guard indexPath.row < heroess.count else {return nil }
        return heroess[indexPath.row]
    }
    

    
    private func sortDescriptor(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMHero.name, ascending: ascending)
        return [sort]
    }
    
    
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didSaveObjectsNotification, object: nil, queue: .main) { notification in
            self.heroess = self.storeDataProvider.fetchHeroes(filter: nil, sorting: self.sortDescriptor(ascending: false))
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
    
