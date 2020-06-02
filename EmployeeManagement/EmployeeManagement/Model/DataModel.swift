//
//  DataModel.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 02/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation

// MARK: - EmployeeInfo
struct EmployeeInfo: Codable {
    var name: String?
    let id: String?
    let band: String?
    let competancy: String?
    let currentProject: String?
    let designation: String?
}

// MARK: - ProjectInfo
struct ProjectInfo: Codable {
    var name: String?
}
