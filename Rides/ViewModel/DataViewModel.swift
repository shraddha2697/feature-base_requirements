//
//  DataViewModel.swift
//  Rides
//
//  Created by Shraddha Jadeja on 2022-11-04.
//

import UIKit

class DataViewModel {
    
    var reloadTableView: (()->())?
    var showError: ((Error?)->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    let apiService = APIService()
    
    private var cellViewModels: [Vehicle] = [Vehicle]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getData(size : String){
        showLoading?()
        apiService.getVehicalData(size: size) { results, error in
            self.hideLoading?()
            if error != nil {
                self.showError?(error)
                return
            }
            
            do{
                guard let data = results else { return }
                let vehicles = try JSONDecoder().decode([Vehicle].self, from: data)
                self.cellViewModels = vehicles
                self.sort(index: 0)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Vehicle {
        return cellViewModels[indexPath.row]
    }
    
    func sort(index : Int){
        if index == 0 {
            let sortedData = cellViewModels.sorted(by: {
                $0.vin < $1.vin
            })
            self.cellViewModels = sortedData
        }
        else{
            let sortedData = cellViewModels.sorted(by: {
                $0.carType < $1.carType
            })
            self.cellViewModels = sortedData
        }
        self.reloadTableView?()
    }
}
