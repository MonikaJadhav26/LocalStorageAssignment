//
//  SaveEmployeeViewModel.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 02/06/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import Foundation
import UIKit

class SaveEmployeeViewModel : NSObject {
    
    
    //MARK: - Create new Employee
    func saveNewEmployee(newEmployee: EmployeeInfo ,completion: @escaping (Result<Bool, Error>) -> Void) {
        CoreDataManager.sharedManager.insertEmployee(employee: newEmployee) { (result) in
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
    
}

