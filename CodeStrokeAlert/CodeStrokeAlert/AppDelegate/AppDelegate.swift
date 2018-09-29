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
import UserNotifications
import Firebase
import FirebaseInstanceID
import CoreLocation
import FirebaseMessaging
import Buglife

let appDelegate         = UIApplication.shared.delegate as! AppDelegate
let loginStoryboard     = UIStoryboard(name: "Main", bundle: nil)
let dashBoardStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    
    var window: UIWindow?
    private let appID = "a704a88e-9e37-41f6-99b8-6ded41926c03"
    var deviceTokenString = "123"
    var Case_ID = 0
    var arrForGroupMembers = [String]()
    var locationManager: CLLocationManager?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        Buglife.shared().start(withEmail: "apps.jaypatel@gmail.com")
        self.locationManager = CLLocationManager()
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            
            self.locationManager?.requestWhenInUseAuthorization()
        }
        
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        self.locationManager?.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        self.locationManager?.delegate = self
        
        //Firebase
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        registerForPushNotifications()
        FirebaseApp.configure()
        
        if let launchOptions = launchOptions {
            
            if let userInfo = launchOptions[UIApplicationLaunchOptionsKey.remoteNotification] as? [AnyHashable : Any] {
                
                let (title, body) = self.getAlert(notification: userInfo as [NSObject : AnyObject])
                print("\(title),\(body)")
                self.Case_ID = title
                self.goToClinicianDeshBordView()
            }
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: appID,
                                        handleNotificationAction: nil,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
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
        WS_GetVersion()
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
    
    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        
        let dataDict:[String: String] = ["token": fcmToken]
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        print(remoteMessage.appData)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void)
    {
        completionHandler([UNNotificationPresentationOptions.alert,UNNotificationPresentationOptions.sound,UNNotificationPresentationOptions.badge])
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    
    // MARK:- LocationManager Delegate -
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        print(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
            
        case .notDetermined:
            print("not determined")
        case .authorizedWhenInUse:
            self.locationManager?.startUpdatingLocation()
            print("authorizedWhenInUse")
        case .denied:
            self.showAlertWithMessageAndActions(message: "Your device's positioning system is disabled. It is essential to determine your position.")
            print("denied")
        case .restricted:
            print("restricted")
        case .authorizedAlways:
            print("authorizedAlways")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // do on error
        print(error)
    }
}

// MARK:- AppDelegate Extension -

extension AppDelegate {
    
    func showAlertWithMessageAndActions(message title: String) {
        
        let alertController = UIAlertController(title: AppConstants.appName, message: title, preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default)
        { action -> Void in
            UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        { action -> Void in
            // Put your code here
        })
        
        DispatchQueue.main.async {
            self.window?.rootViewController!.present(alertController, animated: true, completion: nil) // present the alert
        }
    }
    
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
        print(deviceTokenString)
        
        if deviceTokenString.length > 0 {
            setDeviceToken(deviceTokenString)
        }
        
        Messaging.messaging().apnsToken = deviceToken as Data
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
        let message = "didFailToRegisterForRemoteNotificationsWithError: " + error.localizedDescription
        print(message)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if LoginUserData.savedUser()!.strUserType == "Paramedic" {
            
        } else {
            updateDetail(with: userInfo, completionHandler)
        }
    }
    
    func updateDetail(with userInfo: [AnyHashable : Any], _ completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let (title, body) = self.getAlert(notification: userInfo as [NSObject: AnyObject])
        print("\(title),\(body)")
        self.Case_ID = title
        self.goToClinicianDeshBordView()
    }
    
    private func getAlert(notification: [NSObject:AnyObject]) -> (Int, Int) {
        
        let aps = notification["custom" as NSString] as? [String:AnyObject]
        print(aps!)
        let alert = aps?["a"] as? [String:AnyObject]
        print(alert!)
        let title = alert?["case_id"] as! Int
        return (title, title)
    }
}

