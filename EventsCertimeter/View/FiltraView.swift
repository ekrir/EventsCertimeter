//
//  FiltraView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import UIKit
protocol FiltraViewDelegate {
    func didTapOnApplica()
}

class FiltraView: UIViewController {
    @IBOutlet weak var prezzoTextField: UITextField!
    
    @IBOutlet weak var altriEventiToggle: UISwitch!
    @IBOutlet weak var iMieiEventiToggle: UISwitch!
    @IBOutlet weak var dataToggle: UISwitch!
    @IBOutlet weak var dataPicker: UIDatePicker!
    let backButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("fine", for: .normal)
        return button
    }()
    var delegate: FiltraViewDelegate?
    
    var filtraClass = Filtra.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prezzoTextField.returnKeyType = .done
        //TODO: - aggiungere il back button alla tastiera
        prezzoTextField.inputAccessoryView = backButton
        if let prezzo = filtraClass.prezzo{
            self.prezzoTextField.text = String(prezzo)
        }else {
            self.prezzoTextField.text = nil
        }
        self.altriEventiToggle.isOn = filtraClass.altriEventiToggle
        self.dataToggle.isOn = filtraClass.dataToggleisActive
        self.iMieiEventiToggle.isOn = filtraClass.iMieiEventiToggle
        self.dataPicker.date = filtraClass.dataValue
        self.dataPicker.minimumDate = Date()
    }
    
    @IBAction func filtraPerDataToggle(_ sender: UISwitch) {
        filtraClass.dataToggleisActive = sender.isOn
    }
    
    @IBAction func filtraIMieiEventiToggle(_ sender: UISwitch) {
        filtraClass.iMieiEventiToggle = sender.isOn
    }
    @IBAction func filtraVauleChangedDataTime(_ sender: UIDatePicker) {
        filtraClass.dataValue = sender.date
    }
    @IBAction func filtraValueChangedPrezzo(_ sender: UITextField) {
        if let prezzoNuovo = Double(sender.text ?? "0.0"), prezzoNuovo != 0.0{
            filtraClass.prezzo = prezzoNuovo
        }else {
            filtraClass.prezzo = nil
        }
    }
    @IBAction func applicaFilterPressed(_ sender: Any) {
        
        
        self.navigationController?.popViewController(animated: true)
        delegate?.didTapOnApplica()
    }
    @IBAction func filtraAltriEventiToggle(_ sender: UISwitch) {
        filtraClass.altriEventiToggle = sender.isOn
    }
    


}


class Filtra {
    static let shared = Filtra()
    var dataToggleisActive: Bool
    var dataValue: Date
    var iMieiEventiToggle: Bool
    var altriEventiToggle: Bool
    var prezzo: Double?
    
    init(dataToggleisActive: Bool = false, dataValue: Date = Date(), iMieiEventiToggle: Bool = true, altriEventiToggle: Bool = true, prezzo: Double? = nil) {
        self.dataToggleisActive = dataToggleisActive
        self.dataValue = dataValue
        self.iMieiEventiToggle = iMieiEventiToggle
        self.altriEventiToggle = altriEventiToggle
        self.prezzo = prezzo
    }
}
