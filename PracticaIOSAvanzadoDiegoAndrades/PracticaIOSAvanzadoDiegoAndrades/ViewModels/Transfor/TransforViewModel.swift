//
//  TransforViewModel.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 3/3/24.
//

import Foundation
import CoreData


final class TransforViewModel {
    private var transformaciones: [NSMTransformation] = []
    private var storeDataProvider: StoreDataProviderProtocol
    
    var dataUpdated : (()->Void)?
    
    private var transfor : NSMTransformation

    init(storeDataProvider: StoreDataProviderProtocol = StoreDataProvider.shared,
         transfor: NSMTransformation) {
        self.storeDataProvider = storeDataProvider
        self.transfor = transfor

    }
}


extension TransforViewModel {

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
        return transfor.name
    }
    
    func descriptionHero() -> String? {
        return transfor.informacion
    }
    
    func photoHero() -> String? {
        return transfor.photo
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
    
