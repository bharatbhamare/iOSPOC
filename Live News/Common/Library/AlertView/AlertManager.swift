//
//  AlertManager.swift
//  StructuredProject
//
//  Created by Kiran Sagar Kulkarni on 18/07/19.
//  Copyright © 2019 Kiran Sagar Kulkarni. All rights reserved.
//

import Foundation
import UIKit


class AlertManager: NSObject {
    
    typealias AlertActionHandler = () -> Void
    static var alertVC: AlertViewController!
    
    /// Enum for types of notifications
    enum CRNotificationType {
        case success
        case error
        case info
    }
    
    //show alert message with positive and naegative button. for single button pass negativetitle empty constant.
    static func showCustomAlert(Title title:String, Message message: String,PositiveTitle posBtnTitle:String,NegativeTitle negBtnTitle: String, onPositive positive: @escaping AlertActionHandler, onNegative negative: @escaping AlertActionHandler){
        
        var isCancel = true
        if(negBtnTitle.isEmpty){
            isCancel = false
        }
        
        alertVC = AlertViewController.create().config(title: title, message: message, CancelButton: isCancel)
        alertVC.addAction(AlertAction(title: posBtnTitle, type: .normal, handler: {
            positive()
        }))
        alertVC.addAction(AlertAction(title: negBtnTitle, type: .normal, handler: {
            negative()
        }))
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
        self.alertVC.show(into: window )
        }
    }
    
    static func showCustomInfoAlert(Title title:String? = Constants.kApplicationName, Message message: String,PositiveTitle posBtnTitle:String? = Constants.kAlertTypeOK,View view:UIView = UIApplication.shared.keyWindow!){
        
        alertVC = AlertViewController.create().config(title: title!, message: message, CancelButton: false)
        alertVC.addAction(AlertAction(title: posBtnTitle ?? "", type: .normal, handler: {
            view.endEditing(true)
        }))
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
        self.alertVC.show(into: window )
        }
    }
    
    /// Shows a CRNotification toast from top for given time
    static func showNotification(type: CRNotificationType, title: String, message: String, dismissDelay: Int) {
        
        let view = CRNotification()
        var color = UIColor.black
        var image = UIImage(named: "checked")
        
        switch type {
        case .success:
            color = .green
            image = UIImage(named: "checked")
            break
        case .error:
            color = .gray
            image = UIImage.init(named: "checked")?.withRenderingMode(.alwaysTemplate)
            break
        case .info:
            color = .gray
            image = UIImage(named: "info")
            break
        }
        
        view.backgroundColor = color
        view.setImage(image: image!)
        view.setTitle(title: title)
        view.setMessage(message: message)
        view.setDismisTimer(delay: dismissDelay)
        //THIS CODE NEEDS NAVIGATION CONTROLLER TO BE EMBEDDED
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            window.addSubview(view)
        }
        //UIApplication.shared.keyWindow?.addSubview(view)
        /*let window = UIApplication.shared.keyWindow!
        let v = UIView(frame: window.bounds)
        window.addSubview(v);
        v.backgroundColor = UIColor.black
        let v2 = UIView(frame: CGRect(x: 50, y: 50, width: 100, height: 50))
        v2.backgroundColor = UIColor.white
        v.addSubview(v2)*/
        
    }
    
}
