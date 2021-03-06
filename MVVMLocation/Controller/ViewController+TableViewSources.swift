//
//  ViewController+TableViewSources.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//

import Foundation
import UIKit
import CoreData

extension ViewController {
    func setUpfetchedResultControlelr() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        if self.fetchedResultsController == nil {
            let request: NSFetchRequest<DBLocationDetails> = DBLocationDetails.fetchRequest()
            let sort = NSSortDescriptor(key: "dateTime", ascending: false)
            request.sortDescriptors = [sort]
            self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: delegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            self.fetchedResultsController.delegate = self
        }
                    
        do {
            try self.fetchedResultsController.performFetch()
            self.locationListTableView.reloadData()
        } catch {
            print("Fetch failed")
        }
    }
}

extension ViewController : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.fetchedResultsController == nil {
            return 0
        }
        return fetchedResultsController.sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dbLocationDetails = fetchedResultsController.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "DBCustomeTableViewCellIdentifier") as! DBCustomeTableViewCell
        cell.latlongLabel.text = "\(dbLocationDetails.latitude), \(dbLocationDetails.longitude)"
        cell.detailsLabel.text = "\(dbLocationDetails.sutiation ?? "--")"
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd/MM/yyyy h:mm a"
        cell.dateTimelabel.text =  dateFormat.string(from: dbLocationDetails.dateTime ?? Date())
        return cell
    }
}


extension ViewController : NSFetchedResultsControllerDelegate {
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.locationListTableView.reloadData()
    }

    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        self.locationListTableView.reloadData()
    }
}
