//
//  DBCoreDataServices.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//

import Foundation
import CoreData

class DBCoreDataServices {
    public static func saveLocation(DBLocation location:DBLocation) {
        AppDelegate.getContext { (moc) in
            do {
                let dbLocationDetails = NSEntityDescription.insertNewObject(forEntityName: "DBLocationDetails", into: moc) as! DBLocationDetails
                dbLocationDetails.latitude = location.latitude
                dbLocationDetails.longitude = location.longitude
                dbLocationDetails.dateTime = Date()
                dbLocationDetails.sutiation = location.sutiation
                try moc.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}
