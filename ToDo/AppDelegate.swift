//
//  AppDelegate.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 18/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupEntryPoint()
        return true
    }
    
    // MARK: - setupEntryPoint
    private func setupEntryPoint() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let todoListVC = TodoListViewController.instantiate()
        let navigationVC = UINavigationController(rootViewController: todoListVC)
        window?.rootViewController = navigationVC
        window?.makeKeyAndVisible()
    }

}
