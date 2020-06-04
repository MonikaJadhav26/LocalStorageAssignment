//
//  Project+CoreDataProperties.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 01/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//
//

import Foundation
import CoreData


extension Project {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }
    
    @NSManaged public var name: String?
    
}
