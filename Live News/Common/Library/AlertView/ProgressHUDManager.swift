//
//  ProgressBarManager.swift
//  MySampleTestApp
//
//  Created by Kiran Sagar Kulkarni on 18/07/19.
//  Copyright © 2019 Kiran Sagar Kulkarni. All rights reserved.
//

import Foundation
import UIKit
class ProgressHUDManager: NSObject {
    
    //static var hud : HKProgressHUD? = nil
    
    //shared instance
    static let sharedInstance = ProgressHUDManager()
    static var progressNew : Bool! = false
    private override init() {
        super.init()
    }
    
    static func showProgress (visibility show : Bool){
        // print("BOOL ---------> ",show)
        if show {
            
            
            // print(hud)
            DispatchQueue.main.async {
                if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                    let _ : HKProgressHUD = HKProgressHUD.show(addedToView: window, animated: true)
                }
            }
            
            
        } else{
            DispatchQueue.main.async {
            if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
                _ = HKProgressHUD.hide(addedToView: window, animated: true)
            }
            }
            
            // print(hud)
            
            // DispatchQueue.global(qos: .userInitiated).async {
            
            //  DispatchQueue.main.async {
            //hud.hide(animated: true)
            
        }
    }
    
    
    static func showLoader(){
        if progressNew == false{
            let _ = HKProgressHUD.show(addedToView: UIApplication.shared.keyWindow!, animated: true)
            progressNew = true
        }
    }
    static func hideLoader(){
        if progressNew{
            _ = HKProgressHUD.hide(addedToView: UIApplication.shared.keyWindow!, animated: true)
            progressNew = false
        }
    }
    
}
