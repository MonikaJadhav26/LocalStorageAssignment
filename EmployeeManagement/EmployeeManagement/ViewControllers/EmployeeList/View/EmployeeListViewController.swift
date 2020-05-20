//
//  EmployeeListViewController.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 20/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {

  //MARK: - Outlets and Variables
  @IBOutlet weak var employeeListTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
  //MARK: - Method for UI setup
  func setUpUI() {
    
    self.navigationController?.navigationItem.title = Constants.employeeListTitle
    let rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(rightBarButtonItemTapped(sender:)))
    self.navigationItem.rightBarButtonItem  = rightBarButtonItem
    searchBar.isAccessibilityElement = true
    searchBar.accessibilityIdentifier = "SearchBar"
    employeeListTableView.isAccessibilityElement = true
    employeeListTableView.accessibilityIdentifier = Constants.accessibilityIdentifierForEmployeeListTable
    employeeListTableView.rowHeight = UITableView.automaticDimension
    self.employeeListTableView.register(UINib.init(nibName: Constants.employeeListTableCell, bundle: nil), forCellReuseIdentifier: Constants.kCellIdentifier)
  }
    
  @objc func rightBarButtonItemTapped(sender : UIBarButtonItem) {
    let addViewController = UIStoryboard.init(name: Constants.stodyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.addEmployeeView) as? AddEmployeeViewController
    self.navigationController?.pushViewController(addViewController!, animated: true)
  }

}

//MARK: - UITableview delegate and datasource methods
extension EmployeeListViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCellIdentifier, for: indexPath) as! EmployeeListTableViewCell
    cell.accessibilityIdentifier = "employeeCell_\(indexPath.row)"
//    cell.employeeNameLabel.text = employeeListViewModel.getEmployeeFullName(indexPath: indexPath)
//    cell.employeeAgeLabel.text = employeeListViewModel.getEmployeeAge(indexPath: indexPath)
//    cell.employeeSalaryLabel.text = employeeListViewModel.getEmployeeSalary(indexPath: indexPath)
    cell.employeeProfileImage.image = Constants.defaultImage

    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if (editingStyle == .delete) {
//      let employee = employeeListViewModel.employeeData[indexPath.row]
//      deleteEmployeeViewModel.deleteEmployee(employeeID: Int(employee.id ?? "") ?? 0) { (result) in
//        switch(result) {
//        case .success(let result):
//          if result.status == Constants.success {
//            self.employeeListTableView.beginUpdates()
//            self.employeeListViewModel.employeeData.remove(at: indexPath.row)
//            self.employeeListTableView.deleteRows(at: [indexPath], with: .fade)
//            self.employeeListTableView.endUpdates()
//          } else {
//            self.showAlert(message: result.message, title: Constants.alert , action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
//          }
//
//        case .failure(let error):
//          self.showAlert(message: error.localizedDescription, title: Constants.errorTitle , action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
//        }
//      }
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
}

//MARK: - UISearchBar delegate methods
extension EmployeeListViewController : UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
    searchBar.resignFirstResponder()
  }
  
  func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
    return true
  }
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //employeeListViewModel.searchEmployee(with: searchText) {
      self.employeeListTableView.reloadData()
      if searchText.isEmpty {
        searchBar.resignFirstResponder()
      }
    }
  }


