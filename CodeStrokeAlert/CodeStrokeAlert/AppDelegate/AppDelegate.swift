//
//  AppDelegate.swift
//  CodeStrokeAlert
//
//  Created by Jayesh on 17/06/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import OneSignal
import Firebase
import UserNotifications

let appDelegate         = UIApplication.shared.delegate as! AppDelegate
let loginStoryboard     = UIStoryboard(name: "Main", bundle: nil)
let dashBoardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
    private let appID = "a704a88e-9e37-41f6-99b8-6ded41926c03"
    var deviceTokenString = "123"
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Firebase
        FirebaseApp.configure()
        FirebaseClass.shared.setupFirebase()
        CoreDataClass.shared.setupCoreDate()
        
        registerForPushNotifications()
        
        if let launchOptions = launchOptions {
            
            if let userInfo = launchOptions[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable : Any] {
                
                print(userInfo)
            }
        }
        
        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            // This block gets called when the user reacts to a notification received
            let payload: OSNotificationPayload? = result?.notification.payload
            
            print("Message: \(payload!.body)")
            print("badge number:", payload?.badge ?? "nil")
            print("notification sound:", payload?.sound ?? "nil")
            
            if let additionalData = result!.notification.payload!.additionalData {
                print("additionalData = \(additionalData)")
                
                if let actionSelected = payload?.actionButtons {
                    print("actionSelected = \(actionSelected)")
                }
                
                // DEEP LINK from action buttons
                if let actionID = result?.action.actionID {
                    
                    // For presenting a ViewController from push notification action button
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let actionWebView : UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "WebViewID") as UIViewController
                    let actionSecond: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "SecondID") as UIViewController
                    self.window = UIWindow(frame: UIScreen.main.bounds)
                    
                    print("actionID = \(actionID)")
                    
                    if actionID == "id2" {
                        print("id2")
                        self.window?.rootViewController = actionWebView
                        self.window?.makeKeyAndVisible()
                        
                        
                    } else if actionID == "id1" {
                        print("id1")
                        self.window?.rootViewController = actionSecond
                        self.window?.makeKeyAndVisible()
                    }
                }
            }
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false, kOSSettingsKeyInAppLaunchURL: true, ]
        
        OneSignal.initWithLaunchOptions(launchOptions, appId: appID, handleNotificationAction: notificationOpenedBlock, settings: onesignalInitSettings)
        
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })
        
        UIApplication.shared.statusBarStyle = .lightContent
        IQKeyboardManager.shared.enable = true
        
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack -

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CodeStrokeAlert")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support -

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

// MARK:- AppDelegate Extension -

extension AppDelegate {
    
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    func gotToSigninView() {
        
        for obj in self.window!.subviews {
            obj.removeFromSuperview()
        }
        
        let nav  = loginStoryboard.instantiateViewController(withIdentifier: "LoginNavigation") as! LoginNavigation
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    func goToParamedicDeshBordView() {
        
        for obj in self.window!.subviews {
            obj.removeFromSuperview()
        }
        
        let nav  = dashBoardStoryboard.instantiateViewController(withIdentifier: "ParamedicNavigation") as! DashboardNavigation
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
    
    func goToClinicianDeshBordView() {
        
        for obj in self.window!.subviews {
            obj.removeFromSuperview()
        }
        
        let nav  = dashBoardStoryboard.instantiateViewController(withIdentifier: "ClinicianNavigation") as! DashboardNavigation
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
    }
}

extension AppDelegate {
    
    func registerForPushNotifications() {
        
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted) {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else {
                    
                }
            })
        } else {
            let type: UIUserNotificationType = [.badge, .alert, .sound]
            let setting = UIUserNotificationSettings(types: type, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        deviceTokenString = deviceToken.hexString
        NSLog("LNDeviceToken: %@", deviceTokenString)
        
        if deviceTokenString.length > 0 {
            setDeviceToken(deviceTokenString)
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        let message = "didFailToRegisterForRemoteNotificationsWithError: " + error.localizedDescription
        print(message)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("didReceiveRemoteNotification fetchCompletionHandler", userInfo)
        updateDetail(with: userInfo, completionHandler)
    }
    
    func updateDetail(with userInfo: [AnyHashable : Any], _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if let data = userInfo["alert"] as? [AnyHashable : Any], let value = data["url"] as? String {
            print(data, value)
        } else {
            completionHandler(UIBackgroundFetchResult.noData)
        }
    }
}
