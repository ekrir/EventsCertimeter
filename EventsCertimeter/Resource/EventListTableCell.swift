//
//  EventListTableCell.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import Foundation
import UIKit

class EventListTableCell: UITableViewCell{
    
    @IBOutlet weak var eventInformationLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    
    func configure(_ evento: Evento){
        eventNameLabel.text = evento.nomeEvento
        eventInformationLabel.text = (evento.luogo ?? "informazione non disponibile") + " " + evento.dataInizio.formatted(date: .abbreviated, time: .omitted) 
    }
    
    
    
}
