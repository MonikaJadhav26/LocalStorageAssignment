//
//  AppDelegate.swift
//  EmployeeManagement
//
//  Created by Monika Jadhav on 20/05/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let mainTabBar = MainTabBarViewController()
        window?.rootViewController = mainTabBar
        
        return true
    }
}

