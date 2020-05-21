//
//  AddEmployeeViewController.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 20/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class AddEmployeeViewController: UIViewController {

  
  //MARK: - Outlets and Variables
  @IBOutlet weak var competancyTableView: UITableView!
  var slectedCellIndexPath = IndexPath()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

  //MARK: - Method for UI setup
  func setUpUI() {
    self.title = Constants.addNewEmployee
    let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(rightBarButtonItemTapped(sender:)))
    self.navigationItem.rightBarButtonItem  = rightBarButtonItem
  }
  
  @objc func rightBarButtonItemTapped(sender : UIBarButtonItem) {
    
  }

}

//MARK: - UITableview delegate and datasource methods
extension AddEmployeeViewController : UITableViewDelegate , UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCompentancyCellIdentifier)
    cell?.accessibilityIdentifier = "employeeCell_\(indexPath.row)"
    cell?.textLabel?.text = "Mobility"
    if slectedCellIndexPath == indexPath {
      cell?.imageView?.image = UIImage(named: "checkedRadioButton")
    } else {
      cell?.imageView?.image = UIImage(named: "unCheckedRadioButton")
    }
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    slectedCellIndexPath = indexPath
    competancyTableView.reloadData()
  }

  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 40
  }
  
}
