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
        
       // if !checkRecordForSelectedIdIsExists(id: employee.id ?? "")  {
            
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)!
                                                     
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
            
        let predicate = NSPredicate(format: "(id = %@)", employee.id ?? "")
            fetchRequest.entity = entity
            fetchRequest.predicate = predicate
          
            do {
                       let result = try managedContext.fetch(fetchRequest)
                       if (result.count > 0) {
                           let updatedEmployee = (result[0] as! NSManagedObject) as! Employee
                              updatedEmployee.setValue(employee.name, forKey: "name")
                              updatedEmployee.setValue(employee.band, forKey: "band")
                              updatedEmployee.setValue(employee.competancy, forKey: "competancy")
                              updatedEmployee.setValue(employee.designation, forKey: "designation")
                              updatedEmployee.setValue(employee.currentProject, forKey: "currentProject")
                   }else {
                        let newEmployee = NSManagedObject(entity: entity, insertInto: managedContext)
                               newEmployee.setValue(employee.name, forKey: "name")
                               newEmployee.setValue(employee.id, forKey: "id")
                               newEmployee.setValue(employee.band, forKey: "band")
                               newEmployee.setValue(employee.competancy, forKey: "competancy")
                               newEmployee.setValue(employee.designation, forKey: "designation")
                               newEmployee.setValue(employee.currentProject, forKey: "currentProject")
                }
        }catch {
            let fetchError = error as NSError
            print(fetchError)
        }
            do {
                try managedContext.save()
                completion(.success(true))
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completion(.failure(error))
            }
       // }
    }
    
    func checkRecordForSelectedIdIsExists(id : String) -> Bool {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)!
                                               
        
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
    
    func fetchPerticularEmployeeRecord(id : String, completion: @escaping (Result<[EmployeeInfo], Error>) -> Void) {
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
               let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
               let entityDescription = NSEntityDescription.entity(forEntityName: "Employee", in: managedContext)
               fetchRequest.entity = entityDescription
               let predicate = NSPredicate(format: "(id = %@)", id)
                  fetchRequest.predicate = predicate
               do {
                   var  employeeArray =  [EmployeeInfo]()
                   let result = try managedContext.fetch(fetchRequest)
                   if (result.count > 0) {
                       for employee in result {
                        if employee.id == id {
                           let empObj = EmployeeInfo(name: employee.name ?? "", id: employee.id ?? "", band: employee.band ?? "", competancy: employee.competancy ?? "", currentProject: employee.currentProject ?? "" , designation: employee.designation ?? "")
                           employeeArray.append(empObj)
                        }
                       }
                   }
                   completion(.success(employeeArray))
               } catch {
                   let fetchError = error as NSError
                   print(fetchError)
                   completion(.failure(fetchError))
               }
    }
    
    func fetchAllEmployee(completion: @escaping (Result<[EmployeeInfo], Error>) -> Void)  {
        
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
    
    
    func insertProjects(project : ProjectInfo,completion: @escaping (Result<Bool, Error>) -> Void)  {
        
       // if !checkRecordForSelectedIdIsExists(id: employee.id ?? "")  {
            
            let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
            
            let entity = NSEntityDescription.entity(forEntityName: "Project", in: managedContext)!
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
//
//        let predicate = NSPredicate(format: "(name = %@)", employee.name ?? "")
//            fetchRequest.entity = entity
//            fetchRequest.predicate = predicate
          
                      
                        let newProject = NSManagedObject(entity: entity, insertInto: managedContext)
                        newProject.setValue(project.name, forKey: "name")
                    do {
                try managedContext.save()
                completion(.success(true))
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
                completion(.failure(error))
            }
       // }
    }
    
    
    func fetchAllProjects(completion: @escaping (Result<[ProjectInfo], Error>) -> Void)  {
        
        let managedContext = CoreDataManager.sharedManager.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Project>(entityName: "Project")
        let entityDescription = NSEntityDescription.entity(forEntityName: "Project", in: managedContext)
        
        fetchRequest.entity = entityDescription
        do {
            var  projectsArray =  [ProjectInfo]()
            let result = try managedContext.fetch(fetchRequest)
            if (result.count > 0) {
                for employee in result {
                    let projObj = ProjectInfo(name: employee.name ?? "")
                    projectsArray.append(projObj)
                }
            }
            completion(.success(projectsArray))
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
