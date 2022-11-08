//
//  ViewController.swift
//  Rides
//
//  Created by Shraddha Jadeja on 2022-11-01.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var selectedSegment: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var dataViewModel = DataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Rides"
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    func initViewModel(){
        dataViewModel.reloadTableView = {
            DispatchQueue.main.async { self.tableView.reloadData() }
        }
        dataViewModel.showError = { (error) in
            DispatchQueue.main.async { self.showAlert(error?.localizedDescription ?? "Ups, something went wrong.") }
        }
        
        dataViewModel.showLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.startAnimating()
            }
        }
        dataViewModel.hideLoading = {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
        }
        dataViewModel.getData(size: txtField.text ?? "0" )
    }
    
    //MARK: ACTIONS
    
    @IBAction func btnSubmitClick(_ sender: Any) {
        initViewModel()
    }
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        dataViewModel.sort(index: selectedSegment.selectedSegmentIndex)
    }
}

//MARK: EXTENSIONS

extension ViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataViewModel.numberOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell" , for: indexPath) as! TableViewCell
        let cellVM = dataViewModel.getCellViewModel( at: indexPath )
        cell.cellData(vehicle: cellVM)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.storyboard?.instantiateViewController(withIdentifier: "DetailScreenVC") as! DetailScreenVC
        obj.detailViewModel = DetailViewModel(vehicle: dataViewModel.getCellViewModel( at: indexPath))
        self.navigationController?.pushViewController(obj, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension UIViewController {
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


