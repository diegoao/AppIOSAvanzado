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
    private var locations: [NSMLocation] = []
    private var apiProvider: ApiProvider
    private var storeDataProvider: StoreDataProviderProtocol
    
    var dataUpdated : (()->Void)?
    
    private var hero : NSMHero

    init(apiProvider: ApiProvider = ApiProvider(),
            storeDataProvider: StoreDataProviderProtocol = StoreDataProvider.shared,
         hero: NSMHero) {
        self.apiProvider = apiProvider
        self.storeDataProvider = storeDataProvider
        self.hero = hero
    }
    
    
    
    
}


extension DetailViewModel {

//    func loadData() {
//        transformaciones = Array(self.hero.transformations)
//        locations = Array(self.hero.locations)
//        if locations.isEmpty, transformaciones.isEmpty{
//            apiProvider.getTransformation(id: hero.id ?? ""){ [weak self] result in
//                switch result {
//                case .success(let transformation):
//                    DispatchQueue.main.async {
//                        self?.storeDataProvider.insert(transformations: transformation)
//                        self?.mapDataToHeroCellModel()
//                        self?.notifyDataUpdated()
//                    }
//                case .failure(let error):
//                    print("Error obteniendo datos \(error)")
//                }
//            }
//        }else{
//            notifyDataUpdated()
//        }
//    }
    
    func loadDataFromService() {
        transformaciones = Array(self.hero.transformations)
        locations = Array(self.hero.locations)
        if locations.isEmpty, transformaciones.isEmpty{
            let group = DispatchGroup()
            
            group.enter()
            loadTransformations { error in
                if let error {
                    debugPrint(error)
                }
                group.leave()
            }
            
            group.enter()
            loadLocation { error in
                if let error {
                    debugPrint(error)
                }
                group.leave()
            }
            
            
            group.notify(queue: .main) {
                self.mapDataToHeroCellModel()
                self.notifyDataUpdated()
            }
        }else{
            notifyDataUpdated()
        }
    }
    
    // Con esta función cargo los datos de transformaciones de cada héroe
    func loadTransformations(completion: @escaping ((GokuApiError?)->Void)) {
        apiProvider.getTransformation(id: hero.id ?? ""){ [weak self] result in
            switch result {
            case .success(let transformation):
                DispatchQueue.main.async {
                    self?.storeDataProvider.insert(transformations: transformation)
                    completion(nil)
                }
            case .failure(let error):
                print("Error obteniendo datos \(error)")
                completion(error)
            }
        }
    }
    
    // Con esta función cargo lista de ubicaciones de cada héroe
    func loadLocation(completion: @escaping ((GokuApiError?)->Void)) {
        apiProvider.getLocation(id: hero.id ?? ""){ [weak self] result in
            switch result {
            case .success(let location):
                DispatchQueue.main.async {
                    self?.storeDataProvider.insert(locations: location)
                    completion(nil)
                }
            case .failure(let error):
                print("Error obteniendo datos \(error)")
                completion(error)
            }
        }
    }
    
    
    private func mapDataToHeroCellModel(filter: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil){
        transformaciones = Array(self.hero.transformations)
    }
    

    func notifyDataUpdated() {
        DispatchQueue.main.async {
            self.dataUpdated?()
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
    
    func nameForHero() -> String? {
        return hero.name
    }
    
    func descriptionHero() -> String? {
        return hero.heroDescription
    }
    
    func photoHero() -> String? {
        return hero.photo
    }
    
    func location() -> Void{
        print(hero.locations)
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
    
