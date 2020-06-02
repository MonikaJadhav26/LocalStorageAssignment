//
//  CoreDataManager.swift
//
//
//  Created by Monika Jadhav on 25/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    
    //MARK: - Core Data Stack
    static let sharedManager = CoreDataManager()
    private init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "EmployeeManagement")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.sharedManager.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    var employeeList = Array<Employee>()

    //MARK: - Methods for performing operations on database
    func insertEmployee(employee : EmployeeInfo,completion: @escaping (Result<Bool, Error>) -> Void)  {
        
        if !checkRecordForSelectedIdIsExists(id: employee.id ?? "")  {
            
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Employee",
                                                    in: managedContext)!
            
            let newCity = NSManagedObject(entity: entity,
                                          insertInto: managedContext)
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            
        let predicate = NSPredicate(format: "(id = %@)", employee.id ?? "")
            fetchRequest.entity = entity
            fetchRequest.predicate = predicate
            
        newCity.setValue(employee.name, forKey: "name")
        newCity.setValue(employee.id, forKey: "id")
        newCity.setValue(employee.band, forKey: "band")
        newCity.setValue(employee.competancy, forKey: "competancy")
        newCity.setValue(employee.designation, forKey: "designation")
        newCity.setValue(employee.currentProject, forKey: "currentProject")

            
            do {
                try managedContext.save()
                completion(.success(true))
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completion(.failure(error))
            }
        }
    }
    
    func checkRecordForSelectedIdIsExists(id : String) -> Bool {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Employee",
                                                in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "(id = %d)", id)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            if (result.count > 0) {
                let employee = (result[0] as! NSManagedObject) as! Employee
                if employee.id == id {
                    return true
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        return false
    }
    
    func fetchAllEmployee(completion: @escaping (Result<[EmployeeInfo], Error>) -> Void)  {
        
        employeeList.removeAll()
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        let entityDescription = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)
        
        fetchRequest.entity = entityDescription
        do {
            var  employeeArray =  [EmployeeInfo]()
            let result = try managedContext.fetch(fetchRequest)
            if (result.count > 0) {
                for employee in result {
                    let empObj = EmployeeInfo(name: employee.name ?? "", id: employee.id ?? "", band: employee.band ?? "", competancy: employee.competancy ?? "", currentProject: employee.currentProject ?? "" , designation: employee.designation ?? "")
                    employeeArray.append(empObj)
                }
            }
            completion(.success(employeeArray))
        } catch {
            let fetchError = error as NSError
            print(fetchError)
            completion(.failure(fetchError))
        }
    }
    
    
    
    
    func deleteCity(cityId : Int) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Employee",
                                                in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        let predicate = NSPredicate(format: "(id = %d)", cityId)
        fetchRequest.entity = entity
        fetchRequest.predicate = predicate
        do {
            let result = try managedContext.fetch(fetchRequest)
            if (result.count > 0) {
                let city = (result[0] as! NSManagedObject) as! Employee
                managedContext.delete(city)
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
}
