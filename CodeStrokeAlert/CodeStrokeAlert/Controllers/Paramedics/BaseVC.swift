//
//  BaseVC.swift
//  CodeStrokeAlert
//
//  Created by Jayesh Mardiya on 07/08/18.
//  Copyright © 2018 Jayesh. All rights reserved.
//

import UIKit
import CoreLocation

class BaseVC: UIViewController, CLLocationManagerDelegate {

    // MARK:- Declaration -
    
    var locationManager: CLLocationManager?
    static let notificationIdentifier: String = "UserLocation"
    var isFirstTime: Bool?
    
    // MARK:- ViewController Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK:- Get User Current Location -
    
    internal func updateUserCurrentLocation() {
        
        isFirstTime = true
        
        self.locationManager = CLLocationManager()
        
        guard let locationManager = self.locationManager else {
            return
        }
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // you have 2 choice
            // 1. requestAlwaysAuthorization
            // 2. requestWhenInUseAuthorization
            locationManager.requestWhenInUseAuthorization()
        }
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // The accuracy of the location data
        locationManager.distanceFilter = 200 // The minimum distance (measured in meters) a device must move horizontally before an update event is generated.
        locationManager.delegate = self
    }
    
    // MARK:- CLLocationManagerDelegate -
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else {
            return
        }
        
        if let firstTime = isFirstTime, firstTime == true {
            print(firstTime)
            self.stopUpdatingUserLocation(objectLocation: location)
        }
    }
    
    internal func stopUpdatingUserLocation(objectLocation:CLLocation) {
        
        self.locationManager?.stopUpdatingLocation()
        isFirstTime = false
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: BaseVC.notificationIdentifier), object: nil, userInfo: ["location": objectLocation])
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
    
    // MARK:- Memory Warning -
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Alert Methods -
    
    internal func showAlertWithMessageAndActions(message title: String) {
        
        let alertController = UIAlertController(title: "CodeStrokeAlert", message: title, preferredStyle:UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Confirm", style: UIAlertActionStyle.default)
        { action -> Void in
            UIApplication.shared.open(URL(string:UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: nil)
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        { action -> Void in
            // Put your code here
        })
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil) // present the alert
        }
    }

    // MARK: - Navigation -

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}
