//
//  LiveNewsModel.swift
//  Live News
//
//  Created by MacBook Pro 13" on 1/28/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation

class PersonPostModel : Codable {
    let id : String?
    var groups : [String]?
    var page : String?
    var count : String?
    var keyword : String?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case groups = "groups"
        case page = "page"
        case count = "count"
        case keyword = "keyword"
        
    }
    init(page : String , count : String ,keyword : String){
        self.id =  nil
        self.page = page
        self.count = count
        self.keyword = keyword
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        
    }
    
}
class Person :NSObject, Codable {
    
    let fullname : String?
    let id : String?
    let superuser : String?
    let url : String?
    let status : String?
    init
        (_id : String?,
         _url : String?,superuser : String?,fullname : String? ,status: String?)
    {
        
        self.id = _id
        self.url = _url
        self.fullname = fullname
        self.superuser  = superuser
        self.status = status
    }
    init
        (_id : String?,
         _url : String? )
    {
        
        self.id = _id
        self.url = _url
        self.fullname = nil
        self.superuser  = nil
        self.status = nil
    }
    
    enum CodingKeys: String, CodingKey {
        
        
        case id = "id"
        
        case url = "url"
        
        case fullname = "fullname"
        
        case superuser = "superuser"
        case status = "status"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decodeIfPresent(String.self, forKey: .id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        fullname = try values.decodeIfPresent(String.self, forKey: .fullname)
        superuser = try values.decodeIfPresent(String.self, forKey: .superuser)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
    required convenience init(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeObject(forKey: "id") as! String
        let url = aDecoder.decodeObject(forKey: "url") as! String
        let superuser = aDecoder.decodeObject(forKey: "superuser") as! String
        let fullname = aDecoder.decodeObject(forKey: "fullname") as! String
        let status = aDecoder.decodeObject(forKey: "status") as! String
        self.init(_id : id,
                  _url : url,superuser : superuser,fullname : fullname ,status: status )
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(url, forKey: "url")
        aCoder.encode(fullname, forKey: "fullname")
        aCoder.encode(superuser, forKey: "superuser")
        aCoder.encode(superuser, forKey: "status")
    }
}
