//
//  ViewController + Ext.swift
//  Airbuk
//
//  Created by Apple on 01/12/16.
//  Copyright © 2016 Apple. All rights reserved.
//

import UIKit
import MobileCoreServices
//import ActionSheetPicker_3_0

typealias PickerClosure = (_ enabled: Bool, _ image: UIImage?, _ mediaUrl: URL?, _ isImage: Bool?, _ picker: UIImagePickerController?) -> Void
private var icAssociationKey: UInt8 = 0
private class ClosureWrapper {
    var closure: PickerClosure?
    
    init(_ closure: PickerClosure?) {
        self.closure = closure
    }
}

extension UIViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private var onPickImageComplition: PickerClosure? {
        get {
            let wrapper =
                objc_getAssociatedObject(self, &icAssociationKey) as? ClosureWrapper
            return wrapper?.closure
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &icAssociationKey,
                                     ClosureWrapper(newValue),
                                     .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @objc func showAlertView(_ message:String!) {
        
        let alertController = UIAlertController(title: Constants.kAppName, message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        }
        alertController.addAction(btnOKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func showAlertView(_ message: String!, completionHandler: @escaping (_ value: Bool) -> Void) {
        
        let alertController = UIAlertController(title: Constants.kAppName, message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
            completionHandler(true)
        }
        alertController.addAction(btnOKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func showAlertView(_ message:String!, defaultTitle:String?, cancelTitle:String?, completionHandler: @escaping (_ value: Bool) -> Void) {
        
        let alertController = UIAlertController(title: Constants.kAppName, message: message, preferredStyle: .alert)
        let btnOKAction = UIAlertAction(title: defaultTitle, style: .default) { (action) -> Void in
            completionHandler(true)
        }
        let btnCancelAction = UIAlertAction(title: cancelTitle, style: .default) { (action) -> Void in
            completionHandler(false)
        }
        alertController.addAction(btnOKAction)
        alertController.addAction(btnCancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showCamera(complition: @escaping PickerClosure) {
        self.onPickImageComplition = complition
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            let imagePicker:UIImagePickerController = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.popoverPresentationController?.sourceView = self.view
            imagePicker.popoverPresentationController?.sourceRect = self.view.bounds
            DispatchQueue.main.async {
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    func showActionSheetPhotoPicker(complition: @escaping PickerClosure) {
        
        self.onPickImageComplition = complition
        let actionSheet = UIAlertController(title: "Choose Picture Source", message: nil, preferredStyle: .actionSheet)
        actionSheet.popoverPresentationController?.sourceView = self.view
        actionSheet.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        actionSheet.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 150, width: SCREEN_WIDTH, height: 200)
        
        let Camera = UIAlertAction(title: "Camera", style: .default) { (cameraOpen) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
            {
                let imagePicker:UIImagePickerController = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .camera
                DispatchQueue.main.async {
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
        }
        actionSheet.addAction(Camera)
        
        if self is ChatVC {
            let Video = UIAlertAction(title: "Record video", style: .default) { (cameraOpen) in
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
                {
                    let imagePicker:UIImagePickerController = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera
                    imagePicker.mediaTypes = [kUTTypeMovie as String]
                    DispatchQueue.main.async {
                        self.present(imagePicker, animated: true, completion: nil)
                    }
                }
            }
            let gallery = UIAlertAction(title: "Photo and Video Gallery", style: .default) { (galleryOpen) in
                let imagePicker: UIImagePickerController = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeMovie as String, kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: nil)
            }
            actionSheet.addAction(Video)
            actionSheet.addAction(gallery)
            
        }else {
            let gallery = UIAlertAction(title: "Gallery", style: .default) { (galleryOpen) in
                let imagePicker: UIImagePickerController = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            }
            actionSheet.addAction(gallery)
        }
        
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            print("Cancel")
        }
        actionSheet.addAction(cancel)
        DispatchQueue.main.async {
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true, completion: {() -> Void in
            
            if (info[UIImagePickerControllerMediaType] as! String) == (kUTTypeImage as String) {
                let image: UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
                self.onPickImageComplition!(true, image, info[UIImagePickerControllerMediaURL] as? URL, true, picker)
            }else {
                self.onPickImageComplition!(true, nil, info[UIImagePickerControllerMediaURL] as? URL, false, picker)
            }
        })
        self.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        picker.dismiss(animated: true, completion: {() -> Void in
            self.onPickImageComplition!(false, nil, nil, nil, nil)
        })
               
    }
//    func showDatePicker(origin: Any, minimumDate: Date?, maximumDate: Date?, completionHandler: @escaping (_ success: Bool, _ picker: ActionSheetDatePicker, _ value: Any?, _ target: Any?) -> Void) {
//        let actionSheetDatePicker: ActionSheetDatePicker = ActionSheetDatePicker(title: "Select Date", datePickerMode: .date, selectedDate: Date(), doneBlock: { (picker, value, target) in
//            completionHandler(true, picker!, value, target)
//        }, cancel: { (picker) in
//            completionHandler(false, picker!, nil, nil)
//        }, origin: origin as! UIView)
//        
//        actionSheetDatePicker.toolbarBackgroundColor = utility.RGBColor(r: 230, g: 230, b: 230)
//        if minimumDate != nil {
//            actionSheetDatePicker.minimumDate = minimumDate
//        }
//        if maximumDate != nil {
//            actionSheetDatePicker.maximumDate = maximumDate
//        }
//        actionSheetDatePicker.show()
//    }
    
//    func showStringPicker(title: String, origin: Any, rows: [Any], completionHandler: @escaping (_ success: Bool, _ picker: ActionSheetStringPicker, _ value: Any?, _ target: Any?) -> Void) {
//        
//        ActionSheetStringPicker.show(withTitle: title, rows: rows, initialSelection: 0, doneBlock: { (picker, index, value) in
//            completionHandler(true, picker!, value, origin)
//        }, cancel: { (picker) in
//            completionHandler(false, picker!, nil, nil)
//        }, origin: origin as! UIView)
//    }
}
