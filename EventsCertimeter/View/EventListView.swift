//
//  EventListView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import Foundation
import UIKit
protocol EventListViewDelegate{
    func didTapOnNewEvent(navController: UINavigationController)
}
class EventListView: UIViewController{
    
    
    @IBOutlet weak var EventsTableView: UITableView!
    var listDelegate: UITableViewDelegate?
    var listDataDelegate: UITableViewDataSource?
    var delegate: EventListViewDelegate?
    func configure(){
        
    }
    
    @IBAction func tapNewEvent(_ sender: UIBarButtonItem) {
        print("nuovo evento premuto")
        delegate?.didTapOnNewEvent(navController: self.navigationController ?? UINavigationController())
    }
}
