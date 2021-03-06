//
//  DBLocationDetails+CoreDataProperties.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//
//

import Foundation
import CoreData


extension DBLocationDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBLocationDetails> {
        return NSFetchRequest<DBLocationDetails>(entityName: "DBLocationDetails")
    }

    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var dateTime: Date?
    @NSManaged public var sutiation: String?

}

extension DBLocationDetails : Identifiable {

}
