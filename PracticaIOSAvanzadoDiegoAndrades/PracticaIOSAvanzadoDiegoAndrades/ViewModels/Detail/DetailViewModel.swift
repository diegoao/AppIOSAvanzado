//
//  DetailViewModel.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 3/3/24.
//

import Foundation
import CoreData


final class DetailViewModel {
    private var transformaciones: [NSMTransformation] = []
    private var apiProvider: ApiProvider
    private var storeDataProvider: StoreDataProviderProtocol

    init(apiProvider: ApiProvider = ApiProvider(),
         storeDataProvider: StoreDataProviderProtocol = StoreDataProvider()) {
        self.apiProvider = apiProvider
        self.storeDataProvider = storeDataProvider
    }
    
    
    
    
}


extension DetailViewModel {

    func loadData(id: String) {
        transformaciones = storeDataProvider.fetchTransformations()
        if transformaciones.isEmpty{
            apiProvider.getTransformation(id: id){ [weak self] result in
                switch result {
                case .success(let transformation):
                    DispatchQueue.main.async {
                        self?.storeDataProvider.insert(transformations: transformation)
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
    
    func numTransform() -> Int {
        return transformaciones.count
    }
    
    func transformAt(indexPath: IndexPath) -> NSMTransformation? {
        guard indexPath.row < transformaciones.count else { return nil }
        return transformaciones[indexPath.row]
    }
    
    
    func nameForHero(indexPath: IndexPath) -> String? {
        return transformAt(indexPath: indexPath)?.name
    }
    
    

    

    
    private func sortDescriptor(ascending: Bool = true) -> [NSSortDescriptor] {
        let sort = NSSortDescriptor(keyPath: \NSMHero.name, ascending: ascending)
        return [sort]
    }
    
    
    private func addObservers() {
        NotificationCenter.default.addObserver(forName: NSManagedObjectContext.didSaveObjectsNotification, object: nil, queue: .main) { notification in
            self.transformaciones = self.storeDataProvider.fetchTransformations()
        }
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}
    
