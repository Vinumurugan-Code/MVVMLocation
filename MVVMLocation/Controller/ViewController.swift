//
//  ViewController.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var fetchedResultsController: NSFetchedResultsController<DBLocationDetails>!
    @IBOutlet weak var locationListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.locationListTableView.register(UINib.init(nibName: "DBCustomeTableViewCell", bundle: nil), forCellReuseIdentifier: "DBCustomeTableViewCellIdentifier")
        self.setUpfetchedResultControlelr()
        DBLocationService.shared.startUpdateLocation()
        self.startFetchIngDetails()
    }
    
    func startFetchIngDetails() {
        DBLocationService.shared.getLocationChangeDetails = { (cbLocation) in
            print(cbLocation)
            DBCoreDataServices.saveLocation(DBLocation: DBLocation.init(latitude: cbLocation.latitude, longitude: cbLocation.latitude, sutiation: cbLocation.sutiation))
        }
    }
}

