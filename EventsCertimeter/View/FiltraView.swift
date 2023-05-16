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
    
    @IBAction func filtraPerDataToggle(_ sender: UISwitch) {
    }
    
    @IBAction func filtraIMieiEventiToggle(_ sender: UISwitch) {
    }
    @IBAction func filtraVauleChangedDataTime(_ sender: UIDatePicker) {
    }
    @IBAction func filtraValueChangedPrezzo(_ sender: UITextField) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
