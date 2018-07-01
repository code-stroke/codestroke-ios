//
//  CountrySelection.swift
//  36five
//
//  Created by Jayesh on 11/08/16.
//  Copyright © 2016 Samanvay. All rights reserved.
//

import UIKit

struct CountryCodes {
    
    var name = ""
    var dial_code = ""
    var code = ""
}

let arrCountryCodes = fetchCounrtyCodes()

func fetchCounrtyCodes() -> [CountryCodes] {
    
    let name = "name"
    let dial_code = "dial_code"
    let code = "code"
    
    var countryArray = [CountryCodes]()
    
    guard let filePath = Bundle.main.path(forResource: "CountryList", ofType: "json") else {
        print("File doesnot exist")
        return []
    }
    guard let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
        print("error parsing data from file")
        return []
    }
    do {
        guard let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [[String:String]] else {
            print("json doesnot confirm to expected format")
            return []
        }
        countryArray = jsonArray.map({ (object) -> CountryCodes in
            return CountryCodes(name: object[name]!, dial_code:object[dial_code]!, code: object[code]!)
        })
    }
    catch {
        print("error\(error)")
    }
    return countryArray
}

func getCurrentCountry(_ arr: [CountryCodes], searchFor: String) -> CountryCodes? {
    
    for country in arr {
        if country.code.lowercased() == searchFor.lowercased() {
            return country
        }
    }
    return nil
}

func getCurrentCountryFromCallingCode(_ arr: [CountryCodes], searchFor: String) -> CountryCodes? {
    
    for country in arr {
        if country.dial_code.lowercased() == searchFor.lowercased() {
            return country
        }
    }
    return nil
}

class CountrySelection: NSObject,UIPickerViewDelegate,UIPickerViewDataSource {
    
    class var sharedInstance : CountrySelection {
        struct Static {
            static let instance : CountrySelection = CountrySelection()
        }
        return Static.instance
    }
    
    func openCountryPicker(_ complication : ((CountryCodes) -> ())?){
        let style = RMActionControllerStyle.white
        
        let selectAction = RMAction<UIPickerView>(title: "تائید", style: RMActionStyle.done) { controller in
            
            if let pickerController = controller as? RMPickerViewController{
                if let block = complication {
                    block(arrCountryCodes[Int(pickerController.picker.selectedRow(inComponent: 0) as NSNumber)])
                }
            }
        }
        
        let cancelAction = RMAction<UIPickerView>(title: "لقو", style: RMActionStyle.cancel) { _ in
            print("Row selection was canceled")
        }
        
        let actionController = RMPickerViewController(style: style, title: "", message: "Select Country Code", select: selectAction, andCancel: cancelAction)!;
        
        actionController.picker.tag = 1
        
        //You can enable or disable blur, bouncing and motion effects
        
        actionController.picker.delegate = self;
        actionController.picker.dataSource = self;
        
        //Now just present the date selection controller using the standard iOS presentation method
        appDelegate.window!.rootViewController!.present(actionController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arrCountryCodes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let country = arrCountryCodes[row]
        return ("\(country.name) \(country.dial_code)")
    }
}
