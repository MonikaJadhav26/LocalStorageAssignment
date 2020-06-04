//
//  SaveEmployeeViewModel.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 02/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import UIKit

class SaveEmployeeViewModel : NSObject {
    
    //MARK: - Variables
    var employeeList = Array<EmployeeInfo>()
    var projectList = Array<ProjectInfo>()
    
    
    //MARK: - Create new Employee
    func saveNewEmployee(newEmployee: EmployeeInfo ,completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.insertEmployee(employee: newEmployee) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    //MARK: - Fetch Perticular Employee Data
    func fetchPerticuarEmployee(employeeID : String , completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.fetchPerticularEmployeeRecord(id : employeeID) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.employeeList = result
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    func getProjectList(completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.fetchAllProjects { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.projectList = result
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    
    func getPickerOptionArray() -> Array<String> {
        var pickerOptions = Array<String>()
        
        for project in projectList {
            pickerOptions.append(project.name ?? "")
        }
        
        if pickerOptions.count == 0 {
            pickerOptions.append("Buffer Project")
        }
        return pickerOptions
    }
    
    func getEmployeeFullName() -> String {
        return  self.employeeList[0].name ?? ""
    }
    
    func getEmployeeID() -> String {
        return self.employeeList[0].id ?? ""
    }
    
    func getEmployeeBand() -> String {
        return self.employeeList[0].band ?? ""
    }
    
    func getEmployeeDesignation() -> String {
        return self.employeeList[0].designation ?? ""
    }
    
    func getEmployeeCompetancyName() -> String {
        return self.employeeList[0].competancy ?? ""
    }
    
    func getEmployeeCurrentProjectName() -> String {
        return self.employeeList[0].currentProject ?? ""
    }
}

