//
//  Employee+CoreDataProperties.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 01/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var band: String?
    @NSManaged public var competancy: String?
    @NSManaged public var currentProject: String?
    @NSManaged public var designation: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
