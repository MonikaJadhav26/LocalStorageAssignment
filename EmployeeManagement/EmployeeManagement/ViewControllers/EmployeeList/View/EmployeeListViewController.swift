//
//  EmployeeListViewController.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 20/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class EmployeeListViewController: BaseViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var employeeListTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var employeeListViewModel = EmployeeListViewModel()
    
    
    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getEmployeeListFromURL()
        searchBar.text = ""
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
        navigateToEmployeeDetailsScreen(isEdit: false , employeeID : "")
    }
    
    func navigateToEmployeeDetailsScreen(isEdit : Bool, employeeID : String) {
        let addViewController = UIStoryboard.init(name: Constants.stodyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: Constants.addEmployeeView) as? AddEditEmployeeViewController
        addViewController?.isEdit = isEdit
        if isEdit {
            addViewController?.idForEditEmployee = employeeID
        }
        self.navigationController?.pushViewController(addViewController!, animated: true)
    }
    
    //MARK: - Call to get all data server
    func getEmployeeListFromURL() {
        self.showActivityIndicator()
        employeeListViewModel.fetchAllEmployeeList { result in
            switch(result) {
            case .success:
                self.hideActivityIndicator()
                self.employeeListTableView.reloadData()
            case .failure(let error):
                self.hideActivityIndicator()
                self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
}

//MARK: - UITableview delegate and datasource methods
extension EmployeeListViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeListViewModel.getNumberOfTotalEmployee(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCellIdentifier, for: indexPath) as! EmployeeListTableViewCell
        cell.accessibilityIdentifier = "employeeCell_\(indexPath.row)"
        cell.employeeNameLabel.text = employeeListViewModel.getEmployeeFullName(indexPath: indexPath)
        cell.employeeIdLabel.text = employeeListViewModel.getEmployeeID(indexPath: indexPath)
        cell.employeeCompetancyLabel.text = employeeListViewModel.getEmployeeCompetancyName(indexPath: indexPath)
        cell.employeeDesignationLabel.text = employeeListViewModel.getEmployeeDesignation(indexPath: indexPath)
        cell.employeeCurrentProjectLabel.text = employeeListViewModel.getEmployeeCurrentProjectName(indexPath: indexPath)
        cell.employeeProfileImage.image = employeeListViewModel.getEmployeeProfileIcon(indexPath:indexPath, competancyName :employeeListViewModel.getEmployeeCompetancyName(indexPath: indexPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigateToEmployeeDetailsScreen(isEdit: true, employeeID: employeeListViewModel.getEmployeeID(indexPath: indexPath))
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            employeeListViewModel.deletePerticularEmployeeRecordFromDatabase(employeeID: employeeListViewModel.getEmployeeID(indexPath : indexPath))
        }
        getEmployeeListFromURL()
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
        employeeListViewModel.searchEmployee(with: searchText) {
            self.employeeListTableView.reloadData()
            if searchText.isEmpty {
                searchBar.resignFirstResponder()
            }
        }
    }
}
