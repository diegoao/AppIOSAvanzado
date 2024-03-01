//
//  Hero+CoreDataClass.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//
//

import Foundation
import CoreData

@objc(Hero)
public class Hero: NSManagedObject {

}



extension Hero {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Hero> {
        return NSFetchRequest<Hero>(entityName: "Hero")
    }

    @NSManaged public var photo: String?
    @NSManaged public var name: String?
    @NSManaged public var heroDescription: String?
    @NSManaged public var id: String?
    @NSManaged public var locations: Set<Location>
    @NSManaged public var transformations: Set<Transformation>

}

// MARK: Generated accessors for locations
extension Hero {

    @objc(addLocationsObject:)
    @NSManaged public func addToLocations(_ value: Location)

    @objc(removeLocationsObject:)
    @NSManaged public func removeFromLocations(_ value: Location)

    @objc(addLocations:)
    @NSManaged public func addToLocations(_ values: NSSet)

    @objc(removeLocations:)
    @NSManaged public func removeFromLocations(_ values: NSSet)

}

// MARK: Generated accessors for transformations
extension Hero {

    @objc(addTransformationsObject:)
    @NSManaged public func addToTransformations(_ value: Transformation)

    @objc(removeTransformationsObject:)
    @NSManaged public func removeFromTransformations(_ value: Transformation)

    @objc(addTransformations:)
    @NSManaged public func addToTransformations(_ values: NSSet)

    @objc(removeTransformations:)
    @NSManaged public func removeFromTransformations(_ values: NSSet)

}

extension Hero : Identifiable {

}
