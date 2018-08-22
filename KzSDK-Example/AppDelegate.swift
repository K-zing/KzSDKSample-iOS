//
//  AppDelegate.swift
//  KzSDK-Example
//
//  Created by K-zing on 30/5/2018.
//  Copyright © 2018 K-zing. All rights reserved.
//

import UIKit
import KzSDK_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let apiKey = "YOUR_KEY"
        let md5Key = "YOUR_KEY"

        KzSetting.initialize(apiKey: apiKey, md5Key: md5Key)
        ApiAction.GetBasicKey().addListener(ApiListener<ApiAction.GetBasicKey.Result>.init(onSuccess: { (result) in
            guard let basicKey = result.body?.data?.basicKeyString else {
                self.printResult(result)
                return
            }
            
            KzSetting.setBasicKey(basicKey)
            ApiAction.GetKey().addListener(ApiListener<ApiAction.GetKey.Result>.init(onSuccess: { (result) in
                guard let clientPublicKey = result.body?.data?.publicKeyString else {
                    self.printResult(result)
                    return
                }
                
                //Initialization Completed
                KzSetting.setPublicKey(clientPublicKey)
            }, onFail: self.printResult)).post()
        }, onFail: printResult)).post()

        return true
    }
    
    func printResult(_ result: ApiResultProtocol) {
        print(result)
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

