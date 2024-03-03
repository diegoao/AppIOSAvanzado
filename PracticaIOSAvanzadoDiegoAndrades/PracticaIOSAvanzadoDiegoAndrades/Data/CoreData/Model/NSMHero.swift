//
//  NSMHero+CoreDataClass.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 2/3/24.
//
//

import Foundation
import CoreData

@objc(NSMHero)
public class NSMHero: NSManagedObject {

}


extension NSMHero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NSMHero> {
        return NSFetchRequest<NSMHero>(entityName: "NSMHero")
    }

    @NSManaged public var photo: String?
    @NSManaged public var name: String?
    @NSManaged public var heroDescription: String?
    @NSManaged public var id: String?
    @NSManaged public var locations: Set<NSMLocation>
    @NSManaged public var transformations: Set<NSMTransformation>

}

// MARK: Generated accessors for locations
extension NSMHero {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: NSMLocation)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: NSMLocation)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

// MARK: Generated accessors for transformations
extension NSMHero {

    @objc(addTransformationsObject:)
    @NSManaged public func addToTransformations(_ value: NSMTransformation)

    @objc(removeTransformationsObject:)
    @NSManaged public func removeFromTransformations(_ value: NSMTransformation)

    @objc(addTransformations:)
    @NSManaged public func addToTransformations(_ values: NSSet)

    @objc(removeTransformations:)
    @NSManaged public func removeFromTransformations(_ values: NSSet)

}

extension NSMHero : Identifiable {

}
