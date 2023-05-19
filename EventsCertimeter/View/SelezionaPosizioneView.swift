//
//  SelezionaPosizioneView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import UIKit
import MapKit

protocol SelezionaPosizioneViewDelegate{
    func didTapOnSeleziona(location: CLLocationCoordinate2D)
}

class SelezionaPosizioneView: UIViewController {

    @IBAction func tapOnSeleziona(_ sender: Any) {
        selezionaDelegate?.didTapOnSeleziona(location: locationForPreviousPage)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
    var selezionaDelegate: SelezionaPosizioneViewDelegate?
    private var locationForPreviousPage = CLLocationCoordinate2D()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapOnMap))
        mapView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }

    @objc func tapOnMap(gestureRecognizer: UITapGestureRecognizer){
        let location = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        self.locationForPreviousPage = coordinate
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        
        if mapView.annotations.count >= 1 {
            mapView.removeAnnotations(mapView.annotations)
        }
        mapView.addAnnotation(annotation)
    }
}

extension SelezionaPosizioneView: MKMapViewDelegate{
    
}
