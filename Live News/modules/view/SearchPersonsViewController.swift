//
//  LiveNewsViewController.swift
//  Live News
//
//  Created by MacBook Pro 13" on 1/28/17.
//  Copyright © 2017 pseudo0. All rights reserved.
//

import UIKit

class SearchPersonsViewController: UIViewController {

   // var presenter: ViewToPresenterProtocol?
    let presenter: ViewToPresenterProtocol & InterectorToPresenterProtocol = SearchPersonsPresenter();
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UITextView!
    
    let interactor: PresentorToInterectorProtocol = SearchPersonsInterector();
   // let router: PresenterToRouterProtocol = LiveNewsRouter();
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
        initViews()
        presenter.updateView();
        
    }
    func initViews(){
        self.presenter.view = self;
        //self.presenter.router = router;
        self.presenter.interector = interactor;
        interactor.presenter = self.presenter;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}

extension SearchPersonsViewController: PresenterToViewProtocol {

	func showPersonFetched(personList: [Person]) {
        DispatchQueue.main.async {
            self.authorLabel.text = personList[0].id;
            self.titleLabel.text = personList[0].fullname;
            self.descriptionLabel.text = personList[0].status;
        }
        
    }
    
    func showError() {
        let alert = UIAlertController(title: "Alert", message: "Problem Fetching News", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
