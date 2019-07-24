//
//  Constants.swift
//  MySampleTestApp
//
//  Created by Kiran Sagar Kulkarni on 18/07/19.
//  Copyright © 2019 Kiran Sagar Kulkarni. All rights reserved.
//

import Foundation
import UIKit
class Constants: NSObject {
    public static let postToPerson = "https://qaservices.qpathways.com/otc/posttoperson"
    public static let URL = "https://newsapi.org/v1/articles?source=techcrunch&apiKey=17cf1b333e964cea91e89e1e824bd366";
    public static let NEWS_API_KEY = "17cf1b333e964cea91e89e1e824bd366";
        //MARK:- application constant
        static let kApplicationName         =   "App name"
   
    static let kNoInternetConnection            =       "Not connected to Internet."
    static let SCREEN_SIZE: CGRect      =   UIScreen.main.bounds
    
    //MARK:-All Alerts
    //AlertTitle Constants
    static let kAlertTypeOK                     =       "OK"
    static let kAlertTypeDone                   =       "Done"
    static let kAlertTypeCancel                 =       "Cancel"
    static let kAlertTypeYES                    =       "Yes"
    static let kAlertTypeNO                     =       "No"
    static let kAlertHideCancel                 =       ""
    
    static let kImgDefaultProfilePic            =   "user_profile"
    
    
    //MARK:- font constant
    //FIXME: chagne the font
    static let kFONT_REGULAR            =   "Avenir"
    static let kFONT_AVENIR             =   "Avenir"
    static let kFONT_BOLD               =   "Avenir"
    static let kFONT_LIGHT              =   "Avenir"
    static let kFONT_DEMI_BOLD          =   "AvenirNextCondensed-DemiBold"
}
