//
//  DBCustomeTableViewCell.swift
//  MVVMLocation
//
//  Created by Vinu Murugan on 06/03/21.
//

import UIKit

class DBCustomeTableViewCell: UITableViewCell {

    @IBOutlet weak var latlongLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var dateTimelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
