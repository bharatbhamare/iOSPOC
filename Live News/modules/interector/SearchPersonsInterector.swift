//
//  LiveNewsInterector.swift
//  Live News
//
//  Created by MacBook Pro 13" on 1/28/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation

class SearchPersonsInterector: PresentorToInterectorProtocol{

    var presenter: InterectorToPresenterProtocol?;
    
    func fetchPerson() {
        let requestString = Constants.postToPerson
        let model = PersonPostModel(page : "0",count : "5",keyword : "")
        
        APIWrapperManager.callToRequest(KMethodType: .kTypePOST, APIName: requestString, model: model, isProgressBar: false, isSetHeader: false, onSuccess: { (response) in
            print("RESPONSE ",response)
            if let personList = response.result(model: [Person].self){
            self.presenter?.SearchPersonFetched(personList: personList)
            }
        }) { (error) in
            print("ERROR ",error?.localizedDescription)
        }
    }
}
