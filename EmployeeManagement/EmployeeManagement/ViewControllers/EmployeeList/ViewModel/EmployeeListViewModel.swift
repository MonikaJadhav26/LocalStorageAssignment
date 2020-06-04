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
    var searchedEmployeeData = [EmployeeInfo]()
    var originalEmployeeData = [EmployeeInfo]()
    
    
    //MARK: - Fetch Employee List
    func fetchAllEmployeeList(completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.fetchAllEmployee { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.originalEmployeeData = result
                    self.employeeList = self.originalEmployeeData
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func searchEmployee(with searchText: String, completion: @escaping () -> Void) {
        if !searchText.isEmpty {
            searchedEmployeeData = self.employeeList
            self.employeeList = searchedEmployeeData.filter({ $0.name!.lowercased().contains(searchText.lowercased())})
        } else {
            self.employeeList = self.originalEmployeeData
        }
        completion()
    }
    
    func deletePerticularEmployeeRecordFromDatabase(employeeID : String) {
        CoreDataManager.sharedManager.deleteEmployee(employeeId : employeeID)
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
        return "Competency :\(self.employeeList[indexPath.row].competancy ?? "")"
    }
    
    func getEmployeeCurrentProjectName(indexPath: IndexPath) -> String {
        return "Project :\(self.employeeList[indexPath.row].currentProject ?? "")"
    }
    
    func getEmployeeProfileIcon(indexPath: IndexPath , competancyName : String) -> UIImage {
        
        let competancy = Constants.Competancy(rawValue: competancyName.replacingOccurrences(of: "Competency :", with: ""))!
        
        switch competancy {
        case .iOS:
            return UIImage(named:"ios")!
        case .android:
            return UIImage(named:"android")!
        case .ux:
            return UIImage(named:"ux")!
        default:
            return UIImage(named:"tester")!
        }
    }
}

