//
//  ProjectViewController.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 20/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class ProjectListViewController: BaseViewController {

    //MARK: - Outlets and Variables
    @IBOutlet weak var projectListTableView: UITableView!
    @IBOutlet weak var addProjectTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!

    var addProjectViewModel = AddProjectViewModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getProjectList()
    }
    
    //MARK: - Call to get all data server
       func getProjectList() {
         self.showActivityIndicator()
         addProjectViewModel.fetchAllProjects { result in
           switch(result) {
           case .success:
             self.hideActivityIndicator()
             self.projectListTableView.reloadData()
           case .failure(let error):
             self.hideActivityIndicator()
             self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
           }
         }
       }
    
    //MARK: - Method for Reset all textvalues
    func resetTextField() {
      addProjectTextField.text = ""
    }
    
    //MARK: - Method for Validate all textfileds
    func validate() -> Bool {
      do {
        _ = try addProjectTextField.validatedText(validationType: ValidatorType.projectname)
        
      } catch(let error) {
        let errMessage = (error as! ValidationError).message
        self.showAlert(message: errMessage, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
        return false
      }
      return true
    }
    
    //MARK: - Create Button Action Method
    @IBAction func addButtonClicked(_ sender: UIButton) {
      if validate() {
        self.showActivityIndicator()
        let newProjectInfo = ProjectInfo(name: addProjectTextField.text ?? "")
        addProjectViewModel.addNewProject(project: newProjectInfo) { result in
          switch(result) {
          case .success:
           self.hideActivityIndicator()
            self.resetTextField()
            self.getProjectList()
           self.showAlert(message: Constants.saveProjectSuccessMessage,title : Constants.message, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
          case .failure(let error):
            self.hideActivityIndicator()
            self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
          }
        }
      }
    }
    
}

//MARK: - UITableview delegate and datasource methods
extension ProjectListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addProjectViewModel.getNumberOfTotalProjects(section : section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kProjectCellIdentifier)
        cell?.accessibilityIdentifier = "projectCell_\(indexPath.row)"
        (cell?.contentView.viewWithTag(1) as! UILabel).text = addProjectViewModel.getProjectName(indexPath : indexPath)
        return cell!
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if (editingStyle == .delete) {
       addProjectViewModel.deletePerticularProjectRecordFromDatabase(projectName: addProjectViewModel.getProjectName(indexPath : indexPath))
      }
      getProjectList()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
