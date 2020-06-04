//
//  Constants.swift
//  EmployeeInformationDemo
//
//  Created by Monika Jadhav on 12/05/20.
//  Copyright © 2020 MJ00565663. All rights reserved.
//

import Foundation

import Foundation
import UIKit

struct Constants {
    
    static let kCellIdentifier = "EmployeeListCell"
    static let kCompentancyCellIdentifier = "competancyCell"
    static let kProjectCellIdentifier = "ProjectCell"
    static let employeeListTitle = "Employee List"
    static let addNewEmployee = "Add New Employee"
    static let storyboard = UIStoryboard(name: "Main", bundle: nil)
    static let createNewEmployeeTitle = "Create New Employee"
    static let ok = "OK"
    static let stodyboard = "Main"
    static let employeeListView = "EmployeeListViewController"
    static let addEmployeeView = "AddEditEmployeeViewController"
    static let employeeListTableCell = "EmployeeListTableViewCell"
    static let errorTitle = "Error"
    static let success = "success"
    static let saveEmployeeSuccessMessage = "Employee record saved successfully!"
    static let saveProjectSuccessMessage = "New Project added successfully!"
    static let message = "Message"
    static let alert = "Alert"
    static let defaultImage = UIImage(named: "default")
    static let backgroundViewColor = UIColor(named: "backViewColour")
    static let cellLabelTextColor = UIColor(named: "textColour")
    static let grayButtonColour = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
    static let greenButtonColour = UIColor(red: 38/255, green: 146/255, blue: 66/255, alpha: 1)
    static let accessibilityIdentifierForEmployeeListTable = "EmployeeListTable"
    static let competancyArray = ["Android","iOS","UX","Tester"]
    
    enum Competancy : String {
        case android = "Android"
        case iOS = "iOS"
        case ux = "UX"
        case tester = "Tester"
    }
}
