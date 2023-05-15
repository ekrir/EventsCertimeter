//
//  CompilaNuovoEvento.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import UIKit
protocol CompilaNuovoEventoDelegate{
    func didTapOnSalva()
    func didTapOnQRCode(_ navController: UINavigationController)
    func didTapOnCercaPosizione(_ navController: UINavigationController)
    func didTapOnSelezionaDataInizio(_ viewController: UIViewController)
    func didTapOnSelezionaDataFine(_ navController: UINavigationController)
}

class CompilaNuovoEvento: UIViewController {
    @IBOutlet weak var luogoTextField: UITextField!
    
    @IBOutlet weak var salvaButton: UIButton!
    @IBOutlet weak var qurCodeButton: UIButton!
    @IBOutlet weak var partecipantiTableView: UITableView!
    @IBOutlet weak var dettagliText: UITextView!
    @IBOutlet weak var dataFineTextField: UITextField!
    @IBOutlet weak var dataInizioTextField: UITextField!
    @IBOutlet weak var prezzoTextField: UITextField!
    @IBOutlet weak var nomeTextField: UITextField!
    
    var delegate: CompilaNuovoEventoDelegate?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationItem.backButtonTitle = "indietro"
        setupGraphics()
    }
    
    
    @IBAction func tapOnSalva(_ sender: Any) {
        print("tap on salva")
        delegate?.didTapOnSalva()
    }
    @IBAction func tapOnQRCode(_ sender: Any) {
        delegate?.didTapOnQRCode(self.navigationController ?? UINavigationController())
        print("tapon qr")
    }
    @IBAction func tapOnCercaPosizione(_ sender: Any) {
        delegate?.didTapOnCercaPosizione(self.navigationController ?? UINavigationController())
    }
    @IBAction func tapOnselezionaDataInizio(_ sender: Any) {
        delegate?.didTapOnSelezionaDataInizio(self)
    }
    @IBAction func tapOnselezionaDataFine(_ sender: Any) {
        delegate?.didTapOnSelezionaDataFine(self.navigationController ?? UINavigationController())
    }
    
    func setupGraphics(){
        luogoTextField.layer.borderWidth = 2
        luogoTextField.layer.cornerRadius = 5
        luogoTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        partecipantiTableView.layer.borderWidth = 2
        partecipantiTableView.layer.cornerRadius = 5
        partecipantiTableView.layer.borderColor = UIColor.lightGray.cgColor
        
        prezzoTextField.layer.borderWidth = 2
        prezzoTextField.layer.cornerRadius = 5
        prezzoTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        dataFineTextField.layer.borderWidth = 2
        dataFineTextField.layer.cornerRadius = 5
        dataFineTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        dataInizioTextField.layer.borderWidth = 2
        dataInizioTextField.layer.cornerRadius = 5
        dataInizioTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        nomeTextField.layer.borderWidth = 2
        nomeTextField.layer.cornerRadius = 5
        nomeTextField.layer.borderColor = UIColor.lightGray.cgColor
        
        dettagliText.layer.cornerRadius = 5
        dettagliText.layer.borderWidth = 2
        dettagliText.layer.borderColor = UIColor.lightGray.cgColor
        
        //qui simulo il placeholder per la la cella dei dettagli, che non lo ha come componente nativo
        dettagliText.text = "Dettagli"
        dettagliText.textColor = .placeholderText
        dettagliText.delegate = self
    }
    
    func setValueForDataInizio(_ dataInizio: String){
    }

}

extension CompilaNuovoEvento: UITextViewDelegate{
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
                textView.text = "Dettagli"
                textView.textColor = UIColor.placeholderText
            }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.placeholderText {
                textView.text = nil
                textView.textColor = UIColor.black
            }
    }
}
