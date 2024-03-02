//
//  StoreDataProvider.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//

import Foundation
import CoreData

protocol StoreDataProviderProtocol {
    func insert(heroes: [Hero])
    func fetchHeroes(filter: NSPredicate?, sorting: [NSSortDescriptor]?) -> [NSMHero]
    func insert(transformations: [Transformation])
    func fetchTransformations() -> [NSMTransformation]
    func insert(locations: [Location])
    func fetchLocations () -> [NSMLocation]
    func clearBBDD()
}


enum StorageType {
    case persisted
    case inMemory
}

class StoreDataProvider: StoreDataProviderProtocol {
    
    //importante definir el NSPersistentContainer
    private let persistenCpntainer: NSPersistentContainer!
    
    private static var model: NSManagedObjectModel = {
        let bundle = Bundle(for: StoreDataProvider.self)
        guard let url = bundle.url(forResource: "Model", withExtension: "momd"),
              let model = NSManagedObjectModel(contentsOf:url) else {
            fatalError("Failed to locate mond file")
        }
        return model
    }()
    
    // Actualiza la base de datos con los datos que enviamos en caso de que exista la clave primaria
    lazy var moc: NSManagedObjectContext = {
        var viewcontext = persistenCpntainer.viewContext
        viewcontext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        return viewcontext }()
    
    init(storageType: StorageType = .persisted) {
        self.persistenCpntainer = NSPersistentContainer(name: "Model", managedObjectModel: Self.model)
        if storageType == .inMemory, let persistentStore = self.persistenCpntainer.persistentStoreDescriptions.first {
            // Con este comando le decimos que guarde en memoria
            persistentStore.url = URL(fileURLWithPath: "/dev/null")}
        // Comprobamos que la base de datos se ha podido construir
        self.persistenCpntainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError("No se ha obtenido el persistent Store")
            }
        }
    }
    
    func saveCentext() {
        if moc.hasChanges {
            do{
                try moc.save()
            }catch{
                print("Error guardando contexto \(error.localizedDescription)")
            }
        }
    }
}
        
        
        
extension StoreDataProvider {
    
        func insert(heroes: [Hero]) {
            for hero in heroes {
                let newHero = NSMHero(context: moc)
                newHero.id = hero.id
                newHero.name = hero.name
                newHero.heroDescription = hero.description
                newHero.photo = hero.photo
            }
            saveCentext()
        }
        
        
        func fetchHeroes(filter: NSPredicate? = nil, sorting: [NSSortDescriptor]? = nil) -> [NSMHero] {
            let request = NSMHero.fetchRequest()
            request.predicate = filter
            if sorting == nil {
                let sort = NSSortDescriptor(key: "name", ascending: true)
                request.sortDescriptors = [sort]
            } else {
                request.sortDescriptors = sorting
            }
            do {
                return try moc.fetch(request)
            } catch {
                print(error.localizedDescription)
                return []
            }
        }
        
        
        func insert(transformations: [Transformation]) {
            for trasformation in transformations {
                let newTransformation = NSMTransformation(context: moc)
                newTransformation.id = trasformation.id
                newTransformation.id = trasformation.id
                newTransformation.name = trasformation.name
                newTransformation.informacion = trasformation.description
                newTransformation.photo = trasformation.photo
                
                // Buscamos en Heroes a que heroe pertenece la transformacion
                let filter = NSPredicate(format: "id = %@", trasformation.hero?.id ?? "")
                let hero = fetchHeroes(filter: filter).first
                newTransformation.hero = hero
            }
            saveCentext()
        }
        
        func fetchTransformations() -> [NSMTransformation] {
            let request = NSMTransformation.fetchRequest()
            do {
                return try moc.fetch(request)
            } catch {
                print (error.localizedDescription)
                return []
            }
            
        }
        
        func insert(locations: [Location]) {
            for location in locations {
                let newLocation = NSMLocation(context: moc)
                newLocation.id = location.id
                newLocation.latitude = location.latitude
                newLocation.longitude = location.longitude
                newLocation.date = location.date
                let filter = NSPredicate(format: "id = %@",location.hero?.id ?? "")
                let hero = fetchHeroes(filter: filter).first
                newLocation.hero = hero
            }
            saveCentext()
        }
        
        func fetchLocations() -> [NSMLocation] {
            let request = NSMLocation.fetchRequest()
            do {
                return try moc.fetch(request)
            } catch {
                print(error.localizedDescription)
                return []
            }
        }
        
        func clearBBDD() {
            moc.reset()
            let deleteHeroes = NSBatchDeleteRequest(fetchRequest: NSMHero.fetchRequest())
            let deleteTransformations = NSBatchDeleteRequest(fetchRequest: NSMTransformation.fetchRequest() )
            let deleteLocations = NSBatchDeleteRequest(fetchRequest: NSMLocation.fetchRequest())
            for task in [deleteHeroes, deleteTransformations, deleteLocations] {
                do {
                    try moc.execute (task)
                } catch let error as NSError {
                    print("There was an error removing data from BBDD \(error)")
                }
            }
        }
    }

