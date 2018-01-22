//
//  AppDelegate.swift
//  DOIT
//
//  Created by WANG on 2018/1/12.
//  Copyright © 2018年 WANG. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        if (UserDefaults.standard.value(forKey:UserDefaults_KEY.UserID.rawValue) == nil) {
        
            WPRequest.shared.get(requestInterface:.SetNewUser, data:EventsModel()) { (value:Array) in
                let values:Array = value
                if values.count == 0 {
                    return
                }
                let dict:[String:Any] = values[0] as! [String : Any]
                UserDefaults.standard.set(dict["userID"], forKey:UserDefaults_KEY.UserID.rawValue)
                UserDefaults.standard.set(dict["userName"], forKey:UserDefaults_KEY.UserName.rawValue)
                UserDefaults.standard.set(dict["userDeviceID"], forKey:UserDefaults_KEY.DeviceID.rawValue)
                UserDefaults.standard.set(dict["closeFlow"], forKey:UserDefaults_KEY.closeFlow.rawValue)
                UserDefaults.standard.set(dict["isOpen"], forKey:UserDefaults_KEY.isOpen.rawValue)
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

