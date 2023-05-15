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
        print(sender.isOn)
    }
    
    @IBAction func filtraIMieiEventiToggle(_ sender: UISwitch) {
        print(sender.isOn)
    }
    @IBAction func filtraVauleChangedDataTime(_ sender: UIDatePicker) {
        print(sender.date)
    }
    @IBAction func filtraValueChangedPrezzo(_ sender: UITextField) {
        print(sender.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
