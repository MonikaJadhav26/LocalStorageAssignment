//
//  EmployeeListViewModel.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 02/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import UIKit

class EmployeeListViewModel : NSObject {
    
    //MARK: - Variables
    var employeeList = Array<EmployeeInfo>()
    
    
    //MARK: - Fetch Employee List
    func fetchAllEmployeeList(completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.fetchAllEmployee { (result) in
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
    
    func getNumberOfTotalEmployee(section: Int) -> Int {
        return self.employeeList.count
    }
    
    func getEmployeeFullName(indexPath: IndexPath) -> String {
        
        return "\( self.employeeList[indexPath.row].name ?? "") (\( self.employeeList[indexPath.row].band ?? ""))"

    }
    
    func getEmployeeID(indexPath: IndexPath) -> String {
        return self.employeeList[indexPath.row].id ?? ""
    }
    
    func getEmployeeBand(indexPath: IndexPath) -> String {
        return self.employeeList[indexPath.row].band ?? ""
    }
    
    func getEmployeeDesignation(indexPath: IndexPath) -> String {
        return self.employeeList[indexPath.row].designation ?? ""
    }
    
    func getEmployeeCompetancyName(indexPath: IndexPath) -> String {
        return self.employeeList[indexPath.row].competancy ?? ""
    }
    
    func getEmployeeCurrentProjectName(indexPath: IndexPath) -> String {
        return self.employeeList[indexPath.row].currentProject ?? ""
    }
}

