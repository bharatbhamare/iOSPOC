//
//  LiveNewsPresenter.swift
//  Live News
//
//  Created by MacBook Pro 13" on 1/28/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import Foundation

class SearchPersonsPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?;
    var interector: PresentorToInterectorProtocol?;
    var router: PresenterToRouterProtocol?
    
    func updateView() {
        interector?.fetchPerson();
    }
}

extension SearchPersonsPresenter: InterectorToPresenterProtocol {
    func SearchPersonFetched(personList: [Person]) {
        view?.showPersonFetched(personList: personList)
    }
    
    func SearchPersonFetchedFailed() {
        view?.showError()
    }
}

