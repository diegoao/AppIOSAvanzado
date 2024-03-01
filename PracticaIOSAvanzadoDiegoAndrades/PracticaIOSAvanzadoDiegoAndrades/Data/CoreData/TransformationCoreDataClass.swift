//
//  Transformation+CoreDataClass.swift
//  PracticaIOSAvanzadoDiegoAndrades
//
//  Created by Macbook Pro on 1/3/24.
//
//

import Foundation
import CoreData

@objc(Transformation)
public class Transformation: NSManagedObject {

}


extension Transformation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transformation> {
        return NSFetchRequest<Transformation>(entityName: "Transformation")
    }

    @NSManaged public var id: NSObject?
    @NSManaged public var informacion: NSObject?
    @NSManaged public var name: NSObject?
    @NSManaged public var photo: NSObject?
    @NSManaged public var hero: Hero?

}

extension Transformation : Identifiable {

}
