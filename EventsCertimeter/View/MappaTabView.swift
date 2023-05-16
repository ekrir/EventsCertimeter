//
//  MappaTabView.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import UIKit
import MapKit
import CoreLocation

protocol MappaTabViewDelegate {
    
    func didTapOnFiltra(_ navigationController: UINavigationController)
    
}

class MappaTabView: UIViewController {

    @IBOutlet weak var filtraTabBar: UIBarButtonItem!
    @IBOutlet weak var mappaView: MKMapView!
    
    var locationManager: CLLocationManager?
    
    var delegate: MappaTabViewDelegate?
    
    var listaAnnotazioni: [MyPointAnnotation] = []
    
    func configure(annotations:[MyPointAnnotation]){
        listaAnnotazioni = annotations
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backButtonTitle = "Indietro"
        
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()

        mappaView.showsUserLocation = true
        mappaView.userTrackingMode = .follow
        mappaView.delegate = self
        
            mappaView.addAnnotations(listaAnnotazioni)
        
        
    }
    
    @IBAction func tapOnFiltra(_ sender: Any) {
        delegate?.didTapOnFiltra(self.navigationController ?? UINavigationController())
    }

}


extension MappaTabView: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            manager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation){
        let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mappaView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways{
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self){
                if CLLocationManager.isRangingAvailable(){
                }
            }
        }
    }
}

extension MappaTabView: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationview = mapView.dequeueReusableAnnotationView(withIdentifier: "myAnnotation") as? MKMarkerAnnotationView
        
        if annotationview == nil {
            annotationview = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        }else{
            annotationview?.annotation = annotation
        }
        if let annotation = annotation as? MyPointAnnotation{
            annotationview?.markerTintColor = annotation.pinTintColor
        }
        return annotationview
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(view.annotation?.title)
        print((view.annotation as? MyPointAnnotation)?.pinTintColor == .blue)
    }
}


class MyPointAnnotation : MKPointAnnotation {
    internal init(pinTintColor: UIColor? = nil, evento: Evento) {
        self.pinTintColor = pinTintColor
        self.evento = evento
    }
    
    var pinTintColor: UIColor?
    var evento: Evento
}
