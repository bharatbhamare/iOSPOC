//
//  APIWrapperManager.swift
//  MySampleTestApp
//
//  Created by Kiran Sagar Kulkarni on 18/07/19.
//  Copyright © 2019 Kiran Sagar Kulkarni. All rights reserved.
//

import Foundation
import UIKit
import iOSOBuzzNetwork
class APIWrapperManager: NSObject {
    
    typealias OnSuccessCompletionHandler = (_ receivedString: OBuzzResponse) -> Void
    typealias OnProgressCompletionHandler = (_ receivedString: Progress) -> Void
    typealias OnFailureCompletionHandler = (_ error: Error?) -> Void
    
    
    ///call to login webservice
    
    static func callToRequest<T: Encodable>(KMethodType method:APIRequestManager.kMethodType ,APIName strAPI: String,
                                                   model : T? = nil ,
                                                   isProgressBar : Bool,
                                                   isSetHeader : Bool,
                                                   onSuccess success:@escaping OnSuccessCompletionHandler , onFailure failure: @escaping OnFailureCompletionHandler) {
        
        APIRequestManager.callAPI(KMethodType: method, APIName: strAPI, model: model, isProgressBar: isProgressBar, isSetHeader: isSetHeader, onSuccess: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
        
    }
    
}


