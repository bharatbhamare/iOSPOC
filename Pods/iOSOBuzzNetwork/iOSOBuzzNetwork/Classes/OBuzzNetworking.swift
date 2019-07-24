//
//  OBuzzNetworking.swift
//  Networking
//
//  Created by Gabe The Coder on 10/4/17.
//  Copyright © 2017 Gabe The Coder. All rights reserved.
//

import UIKit

public class OBuzzNetworking {
    
    // MARK: Configuration
    public init() {}
    public class func setServerUrl(url: URL?) {
        OBuzzConfiguration.shared.defaultUrl = url
    }
    
    public class func setAuthHeader(authorization: String) {
        OBuzzConfiguration.shared.defaultAuthorizationHeader = authorization
    }
    public class func setCustomAuthHeader() {
        if let token = UserDefaults.standard.string(forKey: OBuzzCoreConstants.TOKEN) {
            OBuzzConfiguration.shared.defaultAuthorizationHeader = token
        }
    }
    //have to called by client framework
    public class func saveToken(token : String){
        UserDefaults.standard.set(token, forKey: OBuzzCoreConstants.TOKEN)
    }
    public class func getToken() -> String{
        return UserDefaults.standard.string(forKey: OBuzzCoreConstants.TOKEN) ?? ""
    }
    //have to called by client framework
    public class func removeToken(){
    UserDefaults.standard.set("", forKey: OBuzzCoreConstants.TOKEN)
    }

}

extension OBuzzNetworking {
    
    // MARK: HTTP GET
    
    public class func get(route: String,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        OBuzzRequest(route: route,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func getUrl(url: URL?,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        OBuzzRequest(url: url,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
}

extension OBuzzNetworking {
    
    // MARK: HTTP POST
    
    public class func post<T: Encodable>(route: String, model: T,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(model: model)
        OBuzzRequest(route: route, method: .post, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func postData(route: String, data: Any,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(params: data)
        OBuzzRequest(route: route, method: .post, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func postUrl<T: Encodable>(url: URL?, model: T,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(model: model)
        OBuzzRequest(url: url, method: .post, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func postUrlData(url: URL?, data: Any,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(params: data)
        OBuzzRequest(url: url, method: .post, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    public class func postDocuments(url: URL?, docURL : URL?,params: [String: Any]?,filePathKey: String,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        //let params = OBuzzParams(model: model)
        OBuzzRequest(url: url,docURL : docURL,method: .post, params: params, filePathKey: filePathKey, isSetHeader: isSetHeader)?.execute(completion: completion)
    }
    
}

extension OBuzzNetworking {
    
    // MARK: HTTP PUT
    
    public class func put<T: Encodable>(route: String, model: T,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(model: model)
        OBuzzRequest(route: route, method: .put, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func putData(route: String, data: Any,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(params: data)
        OBuzzRequest(route: route, method: .put, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func putUrl<T: Encodable>(url: URL?, model: T,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(model: model)
        OBuzzRequest(url: url, method: .put, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func putUrlData(url: URL?, data: Any,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        let params = OBuzzParams(params: data)
        OBuzzRequest(url: url, method: .put, params: params,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
}

extension OBuzzNetworking {
    
    // MARK: HTTP DELETE
    
    public class func delete(route: String,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        OBuzzRequest(route: route, method: .delete,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
    public class func deleteURL(url: URL?,isSetHeader : Bool, completion: @escaping (OBuzzResponse) -> Void) {
        OBuzzRequest(url: url, method: .delete,isSetHeader : isSetHeader)?.execute(completion: completion)
    }
    
}

extension OBuzzNetworking {
    
    // MARK: Downloaders
    
    public class func downloadImage(string: String, completion: @escaping (UIImage?) -> Void) {
        OBuzzDownload(string: string)?.executeImage(completion: completion)
    }
    
    public class func downloadImage(url: URL?, completion: @escaping (UIImage?) -> Void) {
        OBuzzDownload(url: url)?.executeImage(completion: completion)
    }
    
}
