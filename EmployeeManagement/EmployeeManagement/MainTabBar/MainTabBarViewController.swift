//
//  MainTabBarViewController.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 20/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
    }
    
    func setUpTabBar() {
        let employeeListView = UIStoryboard.init(name: Constants.stodyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "EmployeeListViewController") as? EmployeeListViewController
        let projectListView = UIStoryboard.init(name: Constants.stodyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: "ProjectListViewController") as? ProjectListViewController
        
        let navControllerForEmployeeList = UINavigationController(rootViewController: employeeListView!)
        navControllerForEmployeeList.tabBarItem.title =  "Employees"
        let navControllerForProjectList = UINavigationController(rootViewController: projectListView!)
        navControllerForProjectList.tabBarItem.title = "Projects"
        
        self.viewControllers = [navControllerForEmployeeList,navControllerForProjectList]
      
        UITabBarItem.appearance().setTitleTextAttributes(
               [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 20),
                  NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
    }
    
}
