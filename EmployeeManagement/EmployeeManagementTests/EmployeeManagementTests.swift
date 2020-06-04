//
//  EmployeeManagementTests.swift
//  EmployeeManagementTests
//
//  Created by Monika Jadhav on 04/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import XCTest
@testable import EmployeeManagement

class EmployeeManagementTests: XCTestCase {
    
    var employeeListViewModel = EmployeeListViewModel()
    let saveEmployeeViewModel = SaveEmployeeViewModel()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testEmployeeListViewModelFetchEmployeeDataIsSuccess() {
        let expectation = self.expectation(description: "success")
        employeeListViewModel.fetchAllEmployeeList { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testEmployeeSavedIsSuccess() {
        let newEmployee = EmployeeInfo(name: "Monika Jadhav", id: "565663", band: "U3" , competancy: "Mobility", currentProject: "Buffer Project" , designation: "iOS Developer")
        let expectation = self.expectation(description: "success")
        saveEmployeeViewModel.saveNewEmployee(newEmployee: newEmployee) { (result) in
            switch(result) {
            case .success(let result):
                XCTAssertNotNil(result)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 5, handler: nil)
    }
}


