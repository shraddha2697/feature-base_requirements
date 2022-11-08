//
//  DetailViewModel.swift
//  Rides
//
//  Created by Shraddha Jadeja on 2022-11-07.
//

import Foundation
import UIKit

class DetailViewModel {
    
    var vehicleDetails : Vehicle?
    
    init(vehicle : Vehicle){
        self.vehicleDetails = vehicle
    }
}
