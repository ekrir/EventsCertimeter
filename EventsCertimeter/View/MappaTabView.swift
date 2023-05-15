//
//  MappaTabView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import UIKit
import MapKit

protocol MappaTabViewDelegate {
    
    func didTapOnFiltra(_ navigationController: UINavigationController)
    
}

class MappaTabView: UIViewController {

    @IBOutlet weak var filtraTabBar: UIBarButtonItem!
    @IBOutlet weak var mappaView: MKMapView!
    
    var delegate: MappaTabViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = "Indietro"

        mappaView.showsUserLocation = true
        mappaView.userTrackingMode = .follow
        
        // Do any additional setup after loading the view.
    }
    @IBAction func tapOnFiltra(_ sender: Any) {
        print("tappato su filtra")
        delegate?.didTapOnFiltra(self.navigationController ?? UINavigationController())
    }

}
