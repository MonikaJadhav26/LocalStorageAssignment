
//
//  addProjectViewModel.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 03/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import UIKit

class AddProjectViewModel : NSObject {
    
    //MARK: - Variables
    var projectList = Array<ProjectInfo>()
    
    
    //MARK: - Fetch Project List
    func fetchAllProjects(completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.fetchAllProjects { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success(let result):
                    self.projectList = result
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    
    //MARK: - Fetch Project List
    func addNewProject(project : ProjectInfo,completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.insertProjects(project : project) { (result) in
            DispatchQueue.main.async {
                switch(result) {
                case .success:
                    completion(.success(true))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    func deletePerticularProjectRecordFromDatabase(projectName : String) {
        CoreDataManager.sharedManager.deleteProject(projectName : projectName)
    }
    
    func getNumberOfTotalProjects(section: Int) -> Int {
        return self.projectList.count
    }
    
    func getProjectName(indexPath: IndexPath) -> String {
        return self.projectList[indexPath.row].name ?? ""
    }
}
