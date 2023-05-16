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
    
    var delegate: EventListViewDelegate?
    private var myEvents: [Evento] = []
    private var otherEvents: [Evento] = []
    func configure(myEvents: [Evento], otherEvents: [Evento]){
        self.myEvents = myEvents
        self.otherEvents = otherEvents
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventsTableView.dataSource = self
        EventsTableView.delegate = self
        EventsTableView.register(UINib(nibName: "EventListTableCell", bundle: nil), forCellReuseIdentifier: "EventListTableCell")
        EventsTableView.separatorStyle = .singleLine
    }
    
    @IBAction func tapNewEvent(_ sender: UIBarButtonItem) {
        delegate?.didTapOnNewEvent(navController: self.navigationController ?? UINavigationController())
    }
}


extension EventListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return myEvents.count
        }
        return otherEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableCell") as? EventListTableCell
            cell?.configure(myEvents[indexPath.row])
            return cell ?? UITableViewCell()
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableCell") as? EventListTableCell
            cell?.configure(otherEvents[indexPath.row])
            return cell ?? UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0:
            return "I Miei eventi"
        case 1:
            return "Altri eventi"
        default:
            return ""
        }
    }
    
}
