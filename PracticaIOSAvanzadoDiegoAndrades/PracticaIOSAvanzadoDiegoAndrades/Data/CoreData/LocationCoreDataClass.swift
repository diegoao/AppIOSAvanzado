//
//  Location+CoreDataClass.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {

}


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var hero: Hero?

}

extension Location : Identifiable {

}
