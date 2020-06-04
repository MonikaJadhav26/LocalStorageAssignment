//
//  EmployeeManagementUITests.swift
//  EmployeeManagementUITests
//
//  Created by Monika Jadhav on 04/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import XCTest

class EmployeeManagementUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        
        continueAfterFailure = false
        XCUIApplication().launch()
        app.launch()
        
    }
    
    func testSaveEmployeeSuccessResult()  {
        
        let success = app.staticTexts["Employee record saved successfully!"]
        
        let enteridTextField = app.textFields["Enter id"]
        XCTAssertTrue(enteridTextField.exists)
        enteridTextField.tap()
        enteridTextField.typeText("565663")
        
        let enterFullNameTextField = app.textFields["Enter full name"]
        XCTAssertTrue(enterFullNameTextField.exists)
        enterFullNameTextField.tap()
        enterFullNameTextField.typeText("Monika Jadhav")
        
        let enterBandTextField = app.textFields["Enter band"]
        XCTAssertTrue(enterBandTextField.exists)
        enterBandTextField.tap()
        enterBandTextField.typeText("U3")
        
        let enterDesignationTextField = app.textFields["Enter designation"]
        XCTAssertTrue(enterDesignationTextField.exists)
        enterDesignationTextField.tap()
        enterDesignationTextField.typeText("iOS Developer")
        
        let enterCompetencyTextField = app.textFields["Select competancy"]
        XCTAssertTrue(enterCompetencyTextField.exists)
        enterCompetencyTextField.tap()
        enterCompetencyTextField.typeText("Mobility")
        
        let enterProjectTextField = app.textFields["Select current project"]
        XCTAssertTrue(enterProjectTextField.exists)
        enterProjectTextField.tap()
        enterProjectTextField.typeText("Buffer Project")
        
        let saveButton = app.buttons["Save"]
        XCTAssertTrue(saveButton.exists)
        saveButton.tap()
        
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: success, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(success.exists, "Employee created successfully! is displayed")
        
    }
    
    func testTextfieldExists() {
        let enterFullNameTextField = app.textFields["ProjectTextField"]
        XCTAssertTrue(enterFullNameTextField.exists)
    }
    
}
