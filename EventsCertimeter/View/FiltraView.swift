//
//  FiltraView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import UIKit
protocol FiltraViewDelegate {
    
}

class FiltraView: UIViewController {
  
    var delegate: FiltraViewDelegate?
    
    var filtraClass = Filtra.shared
    
    @IBAction func filtraPerDataToggle(_ sender: UISwitch) {
    }
    
    @IBAction func filtraIMieiEventiToggle(_ sender: UISwitch) {
    }
    @IBAction func filtraVauleChangedDataTime(_ sender: UIDatePicker) {
    }
    @IBAction func filtraValueChangedPrezzo(_ sender: UITextField) {
    }
    @IBAction func applicaFilterPressed(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

}


class Filtra {
    static let shared = Filtra()
    var dataToggleisActive: Bool = false
    var dataValue = Data()
    var iMieiEventiToggle = true
    var Prezzo: Double? = nil
}
