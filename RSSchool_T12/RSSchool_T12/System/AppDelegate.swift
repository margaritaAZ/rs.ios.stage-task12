//
//  AppDelegate.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 22.09.21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        let navController = UINavigationController(rootViewController: WalletsListViewController())
//        navController.navigationBar.isHidden = true
        let navController = UINavigationController()
        let assemblyBuilder = AssemblyBuilder()
        let router = Router(navigationController: navController, assemblyBuilder: assemblyBuilder)
        router.initialViewController()
        navController.navigationBar.isHidden = true
        window?.rootViewController = navController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        //FIXME: when save context
//        CoreDataManager.sharedManager.saveContext()
    }
}

