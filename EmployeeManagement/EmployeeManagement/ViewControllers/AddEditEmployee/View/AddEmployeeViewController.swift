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
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bandTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var competencyTextField: UITextField!
    @IBOutlet weak var projectTextField: UITextField!
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!

  var slectedCellIndexPath = IndexPath()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
      manageScrollView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

         }
    
    override func viewDidLayoutSubviews() {
           super.viewDidLayoutSubviews()
           
           let yMax = projectTextField.frame.origin.y + projectTextField.frame.size.height + 12
           scrollContentViewHeightConstraint.constant = yMax
       
       }

       private func manageScrollView(){
           var lastView : UIView?
           lastView = projectTextField
           let yMax = lastView!.frame.origin.y + lastView!.frame.size.height + 12
           scrollContentViewHeightConstraint.constant = yMax
           backgroundScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: yMax)
           self.view.layoutIfNeeded()
       }

  //MARK: - Method for UI setup
  func setUpUI() {
    self.title = Constants.addNewEmployee
    let rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(rightBarButtonItemTapped(sender:)))
    self.navigationItem.rightBarButtonItem  = rightBarButtonItem
  }
  
  @objc func rightBarButtonItemTapped(sender : UIBarButtonItem) {
    
  }
    
    @objc func keyboardWillShow(notification: NSNotification) {
         print("keyboardWillShow")
        let keyboardHeight: CGFloat = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0
        self.bottomConstraint.constant  = keyboardHeight - 49
    }

    @objc func keyboardWillHide(notification: NSNotification){
         print("keyboardWillHide")
        self.bottomConstraint.constant = 120.0

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

extension AddEmployeeViewController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return true
    }
    
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
