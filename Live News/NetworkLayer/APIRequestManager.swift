//
//  APIRequestManager.swift
//  MySampleTestApp
//
//  Created by Kiran Sagar Kulkarni on 18/07/19.
//  Copyright © 2019 Kiran Sagar Kulkarni. All rights reserved.
//

import UIKit
import iOSOBuzzNetwork
import SystemConfiguration

class APIRequestManager: NSObject {
    
    //mark:- static declaration
    
    //static let kBaseURL = " "
    static let kBaseURL = ""
    
    static let KAPIuploadProfilePicture = ""
    static let KAPIdownloadURL = "https://static.pexels.com/photos/60006/spring-tree-flowers-meadow-60006.jpeg"
    
    enum kMethodType : Int {
        case kTypeGET = 0
        case kTypePOST
        case kTypeFORM_POST
    }
    
    static let sharedInstance = APIRequestManager()
    private override init() {
        super.init()
    }
    
    typealias OnSuccessCompletionHandler = (_ receivedString: OBuzzResponse) -> Void
    typealias OnFailureCompletionHandler = (_ error: Error?) -> Void
    
    
    static func callAPI<T: Encodable>(KMethodType method:kMethodType ,APIName strAPI: String,model: T? = nil,isProgressBar:Bool? = true,isSetHeader : Bool? = false, onSuccess success: @escaping OnSuccessCompletionHandler, onFailure failure:
        @escaping OnFailureCompletionHandler) {
        
        if APIRequestManager.sharedInstance.startNetworkReachabilityObserver(){
            if isProgressBar!{
                ProgressHUDManager.showProgress(visibility: true)
            }
            let requestURL = URL(string: strAPI)
            switch method{
            case .kTypeGET :
                OBuzzNetworking.getUrl(url: requestURL, isSetHeader: isSetHeader ?? false) { (response) in
                    if isProgressBar! {
                        ProgressHUDManager.showProgress(visibility: false)
                        
                    }
                    if response.statusCode == 200{
                        print(response)
                        success(response)
                    }else if  response.statusCode >= 400 && response.statusCode < 500 {
                        print("client side errors 400-500")
                        failure(response.error)
                    }else if response.statusCode >= 500 && response.statusCode < 600{
                        print("server side errors")
                        failure(response.error)
                    }
                    
                }
            case .kTypePOST:
                OBuzzNetworking.postUrl(url: requestURL, model: model, isSetHeader: isSetHeader ?? false) { (response) in
                    if isProgressBar! {
                        ProgressHUDManager.showProgress(visibility: false)
                        
                    }
                    if response.statusCode == 200{
                        print(response)
                        success(response)
                    }else if  response.statusCode >= 400 && response.statusCode < 500 {
                        print("client side errors 400-500")
                        failure(response.error)
                    }else if response.statusCode >= 500 && response.statusCode < 600{
                        print("server side errors")
                        failure(response.error)
                    }
                }
            case .kTypeFORM_POST:
                print("no added code")
            }
        }else{
            if !isProgressBar!{
                failure(NSError.init(domain: Constants.kNoInternetConnection, code: 0, userInfo: nil))
            }
        }
    }
    /*
    static func downloadFile(downloadURL strAPI: String, onSuccess success: @escaping OnSuccessCompletionHandler, onFailure failure:
        @escaping OnFailureCompletionHandler,onDownloadProgress progress: @escaping OnSuccessCompletionHandler ) {
        
        let utilityQueue = DispatchQueue.global(qos: .utility)
        
        Alamofire.download(KAPIdownloadURL)
            .downloadProgress(queue: utilityQueue) { progressCompleted in
                Utility.print("Download Progress: \(progressCompleted.fractionCompleted)")
                progress(progressCompleted)
            }
            .responseData { response in
                
                let httpStatusCode = response.response?.statusCode
                switch response.result {
                case .success:
                    success(response.result.value!)
                case .failure(let error):
                    Utility.print(error)
                    
                    if  httpStatusCode! >= 400 && httpStatusCode! < 500 {
                        Utility.print("client side errors 400-500")
                        
                    }else if httpStatusCode! >= 500 && httpStatusCode! < 600{
                        Utility.print("server side errors")
                        
                    }
                    failure(error)
                }
        }
    }
    
    */
    ///network connection observer
    
    func startNetworkReachabilityObserver() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        //let isWWAN = flags.contains(.isWWAN)
        let needsConnection = flags.contains(.connectionRequired)
        if(isReachable == false && needsConnection == false){
            
           // AlertManager.showNotification(type: AlertManager.CRNotificationType.error, title: Constants.kApplicationName, message: Constants.kNoInternetConnection, dismissDelay: 3)
            AlertManager.showNotification(type: AlertManager.CRNotificationType.error, title: Constants.kApplicationName, message: Constants.kNoInternetConnection, dismissDelay: 5)
            
            print("NO INTERNET CONNECTION")
            
        }
        
        return (isReachable && !needsConnection)
    }
    
    
    
}


