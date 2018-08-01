//
//  CustomMediaViewer.swift
//  DailyDoc
//
//  Created by Bharat Nakum on 6/29/17.
//  Copyright © 2017 Bharat Nakum. All rights reserved.
//

import Foundation
import AKMediaViewer

class CustomMediaViewer: NSObject {
    fileprivate var mediaFocusManager = AKMediaViewerManager()
    fileprivate var theController: UIViewController? = nil
    fileprivate var thePathURL: URL? = nil
    fileprivate var isVideo: Bool = false
    
    @objc init(controller: UIViewController, pathURL: URL, isForVideo: Bool) {
        theController = controller
        thePathURL = pathURL
        isVideo = isForVideo
    }
    
    @objc func showMediaOnTheView(theView: UIView) {
        mediaFocusManager.delegate = self
        mediaFocusManager.elasticAnimation = true
        mediaFocusManager.focusOnPinch = true
        mediaFocusManager.addPlayIconOnVideo = false
        
        mediaFocusManager.installOnView(theView)
        
        mediaFocusManager.startFocusingView(theView)
    }
}

extension CustomMediaViewer: AKMediaViewerDelegate {
    func parentViewControllerForMediaViewerManager(_ manager: AKMediaViewerManager) -> UIViewController {
        return theController!
    }
    
    func mediaViewerManager(_ manager: AKMediaViewerManager, mediaURLForView view: UIView) -> URL {
        return thePathURL!
    }
    
    func mediaViewerManager(_ manager: AKMediaViewerManager, titleForView view: UIView) -> String {
        return ""
    }
    
    func mediaViewerManagerWillAppear(_ manager: AKMediaViewerManager) {
        /*
         *  Call here setDefaultDoneButtonText, if you want to change the text and color of default "Done" button
         *  eg: mediaFocusManager!.setDefaultDoneButtonText("Panda", withColor: UIColor.purple)
         */
        UIApplication.shared.isStatusBarHidden = true
    }
    
    func mediaViewerManagerWillDisappear(_ mediaFocusManager: AKMediaViewerManager) {
        UIApplication.shared.isStatusBarHidden = false
    }
}
