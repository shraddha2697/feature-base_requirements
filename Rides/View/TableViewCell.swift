//
//  TableViewCell.swift
//  Rides
//
//  Created by Shraddha Jadeja on 2022-11-01.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellData(vehicle : Vehicle){
        self.lbl1.text = vehicle.vin
        self.lbl2.text = vehicle.makeAndModel
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
