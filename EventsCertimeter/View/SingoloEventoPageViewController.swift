//
//  SingoloEventoPageViewController.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 18/05/23.
//

import UIKit

protocol SingoloEventoPageViewControllerDelegate{
    func didTapOnApplicaEvento(evento: Evento)
}

class SingoloEventoPageViewController: UIViewController {
    @IBOutlet weak var partecipaButton: UIButton!
    
    @IBOutlet weak var nomeEventoLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var dataFineLabel: UILabel!
    @IBOutlet weak var dataInizioLabel: UILabel!
    private var evento = Evento()
    private var shoWButton = false
    var singoloEventoDelegate: SingoloEventoPageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()

        // Do any additional setup after loading the view.
    }
    
    func configure(evento: Evento, showPulsante: Bool){
        self.evento = evento
        shoWButton = showPulsante
    }
    func setup(){
        partecipaButton.isHidden = !shoWButton
        nomeEventoLabel.text = evento.nomeEvento
        dataInizioLabel.text = evento.dataInizio.formatted()
        dataFineLabel.text = evento.dataFine.formatted()
        noteLabel.text = evento.descrizione ?? "-"
        
    }

    @IBAction func tapOnPartecipa(_ sender: Any) {
        singoloEventoDelegate?.didTapOnApplicaEvento(evento: evento)
    }
}
