//
//  DetailScreenVC.swift
//  Rides
//
//  Created by Shraddha Jadeja on 2022-11-06.
//

import UIKit

class DetailScreenVC: UIViewController {
    
    //MARK: OUTLETS
    
    @IBOutlet weak var lblVin: UILabel!
    @IBOutlet weak var lblMakeAndModel: UILabel!
    @IBOutlet weak var lblColour: UILabel!
    @IBOutlet weak var lblCarType: UILabel!
    
    var detailViewModel : DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVehicleData()
    }
        
    func setVehicleData() {
        guard let data = detailViewModel?.vehicleDetails else {
            return
        }
        self.lblVin.text = data.vin
        self.lblColour.text = data.color
        self.lblMakeAndModel.text = data.makeAndModel
        self.lblCarType.text = data.carType
    }
}
