//
//  AppDelegate.swift
//  TestApp
//
//  Created by Юля Пономарева on 12.07.17.
//  Copyright © 2017 Юля Пономарева. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        let rootVC = UINavigationController()
        let mainController = ViewController()
        rootVC.setViewControllers([mainController], animated: true)
        rootVC.isNavigationBarHidden = true
        rootVC.navigationBar.isTranslucent = false
        
        window?.rootViewController = rootVC
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

