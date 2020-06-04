//
//  AddEditEmployeeViewController.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 01/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class AddEditEmployeeViewController: BaseViewController {
    
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    @IBOutlet weak var competancyTableView: UITableView!
    @IBOutlet weak var iDView: UVCustomView!
    @IBOutlet weak var bandTextView: UVCustomView!
    @IBOutlet weak var designationTextView: UVCustomView!
    @IBOutlet weak var competancyTextView: UVCustomView!
    @IBOutlet weak var projectTextView: UVCustomView!
    @IBOutlet weak var nameTextView: UVCustomView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var save: UIButton!
    
    var slectedCellIndexPath = IndexPath()
    let saveEmployeeViewModel = SaveEmployeeViewModel()
    var isEdit : Bool?
    var idForEditEmployee : String?
    var isEditOn : Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setControlsAndData()
        manageScrollView()
        setConstraintValueForCustomViews()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let yMax = projectTextView.frame.origin.y + projectTextView.frame.size.height + 12
        scrollContentViewHeightConstraint.constant = yMax
    }
    
    func setControlsAndData()  {
        iDView.customViewTextFieldDelegate = self
        nameTextView.customViewTextFieldDelegate = self
        bandTextView.customViewTextFieldDelegate = self
        designationTextView.customViewTextFieldDelegate = self
        competancyTextView.customViewTextFieldDelegate = self
        projectTextView.customViewTextFieldDelegate = self
    }
    private func manageScrollView(){
        var lastView:UIView?
        lastView = projectTextView
        let yMax = lastView!.frame.origin.y + lastView!.frame.size.height + 12
        scrollContentViewHeightConstraint.constant = yMax
        backgroundScrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: yMax)
        self.view.layoutIfNeeded()
    }
    
    private func setConstraintValueForCustomViews(){
        projectTextView.bottomViewContraint = bottomConstraint
        projectTextView.parentController = self
        projectTextView.scrollContentHeightViewContraint?.constant = scrollContentViewHeightConstraint.constant
        projectTextView.scrollView = self.backgroundScrollView
        projectTextView.addNotificationForKeyboard()
        
        competancyTextView.bottomViewContraint = bottomConstraint
        competancyTextView.parentController = self
        competancyTextView.scrollView = self.backgroundScrollView
        
        competancyTextView.scrollContentHeightViewContraint?.constant = scrollContentViewHeightConstraint.constant
        competancyTextView.addNotificationForKeyboard()
        
        getPickerOptionForProjectList()
        
    }
    
    func getPickerOptionForProjectList() {
        self.showActivityIndicator()
        saveEmployeeViewModel.getProjectList { result in
            switch(result) {
            case .success:
                self.hideActivityIndicator()
                self.projectTextView.pickerOption = self.saveEmployeeViewModel.getPickerOptionArray()
            case .failure(let error):
                self.hideActivityIndicator()
                self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
    
    //MARK: - Method for UI setup
    func setUpUI() {
        self.title = Constants.addNewEmployee
        
        if isEdit! {
            setControlsForEdit(textColour : .darkGray , isEditOn : false)
            isEditOn = true
            let rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(rightBarButtonItemTapped(sender:)))
            self.navigationItem.rightBarButtonItem  = rightBarButtonItem
            iDView.textField.isUserInteractionEnabled =  false
            iDView.textField.textColor = .darkGray
            getEmployeeData()
        }else {
            save.isEnabled = false
            save.backgroundColor = .lightGray
        }
    }
    
    @objc func rightBarButtonItemTapped(sender : UIBarButtonItem) {
        setControlsForEdit(textColour : .black , isEditOn : true)
        if isEditOn! {
            self.save.isEnabled = true
            self.save.backgroundColor = Constants.greenButtonColour
        }else {
            self.save.isEnabled = false
            self.save.backgroundColor = .lightGray
        }
    }
    
    func setControlsForEdit(textColour : UIColor , isEditOn : Bool) {
        nameTextView.textField.isUserInteractionEnabled = isEditOn
        designationTextView.textField.isUserInteractionEnabled = isEditOn
        competancyTextView.textField.isUserInteractionEnabled = isEditOn
        projectTextView.textField.isUserInteractionEnabled = isEditOn
        bandTextView.textField.isUserInteractionEnabled = isEditOn
        competancyTableView.isUserInteractionEnabled = isEditOn
    }
    
    //MARK: - Call to get perticular employee data
    func getEmployeeData() {
        self.showActivityIndicator()
        saveEmployeeViewModel.fetchPerticuarEmployee(employeeID : idForEditEmployee!) { result in
            switch(result) {
            case .success:
                self.hideActivityIndicator()
                self.setValuesForAllControls()
            case .failure(let error):
                self.hideActivityIndicator()
                self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
    
    func setValuesForAllControls() {
        iDView.textField.text = saveEmployeeViewModel.getEmployeeID()
        nameTextView.textField.text = saveEmployeeViewModel.getEmployeeFullName()
        bandTextView.textField.text = saveEmployeeViewModel.getEmployeeBand()
        designationTextView.textField.text = saveEmployeeViewModel.getEmployeeDesignation()
        competancyTextView.textField.text = saveEmployeeViewModel.getEmployeeCompetancyName()
        projectTextView.textField.text = saveEmployeeViewModel.getEmployeeCurrentProjectName()
    }
    
    //MARK: - Method for Reset all textvalues
    func resetTextField() {
        nameTextView.textField.text = ""
        projectTextView.textField.text = ""
        competancyTextView.textField.text = ""
        designationTextView.textField.text = ""
        bandTextView.textField.text = ""
        iDView.textField.text = ""
    }
    
    //MARK: - Method for Validate all textfileds
    func validate() -> Bool {
        do {
            _ = try nameTextView.textField.validatedText(validationType: ValidatorType.employeename)
            _ = try projectTextView.textField.validatedText(validationType: ValidatorType.projectname)
            _ = try designationTextView.textField.validatedText(validationType: ValidatorType.designation)
            _ = try bandTextView.textField.validatedText(validationType: ValidatorType.band)
            
        } catch(let error) {
            let errMessage = (error as! ValidationError).message
            self.showAlert(message: errMessage, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            return false
        }
        return true
    }
    
    //MARK: - Create Button Action Method
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        if validate() {
            self.showActivityIndicator()
            
            let newEmployeeInfo = EmployeeInfo(name: nameTextView.textField.text ?? "", id: iDView.textField.text ?? "", band: bandTextView.textField.text ?? "" , competancy: competancyTextView.textField.text ?? "", currentProject: projectTextView.textField.text ?? "" , designation: designationTextView.textField.text ?? "")
            
            saveEmployeeViewModel.saveNewEmployee(newEmployee: newEmployeeInfo) { result in
                switch(result) {
                case .success:
                    self.hideActivityIndicator()
                    if self.isEdit! {
                        self.setControlsForEdit(textColour : .darkGray , isEditOn : false)
                        self.save.isEnabled = false
                        self.save.backgroundColor = .lightGray
                    }else {
                        self.resetTextField()
                    }
                    self.showAlert(message: Constants.saveEmployeeSuccessMessage,title : Constants.message, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                case .failure(let error):
                    self.hideActivityIndicator()
                    self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
                }
            }
        }
    }
    
}
//MARK: - UITableview delegate and datasource methods
extension AddEditEmployeeViewController : UITableViewDelegate , UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.competancyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kCompentancyCellIdentifier)
        cell?.accessibilityIdentifier = "employeeCell_\(indexPath.row)"
        cell?.textLabel?.text = Constants.competancyArray[indexPath.row]
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
        competancyTextView.textField.text = Constants.competancyArray[indexPath.row]
        competancyTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
extension AddEditEmployeeViewController:  UVCustomViewTextFieldDelegate  {
    func textFieldTextDidChange(textField:UITextField) {
        
        
        if !((bandTextView.textField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && !((designationTextView.textField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && !((competancyTextView.textField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && !((projectTextView.textField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)! && !((nameTextView.textField.text)?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!{
            
            save.isEnabled = true
            save.backgroundColor = Constants.greenButtonColour
        } else {
            save.isEnabled = false
            save.backgroundColor = .lightGray
        }
    }
    func doneButtonTappedForPickerView(sender : UIBarButtonItem , pickerView : UIPickerView , textField : UITextField, pickerValue: String) {
        
        projectTextView.textField.text = pickerValue
        self.textFieldTextDidChange(textField: projectTextView.textField)
        textField.resignFirstResponder()
        
    }
    
    func pickerValueDidChange(pickerValue: String, textField: UITextField) {
        print(pickerValue)
    }
    
}


