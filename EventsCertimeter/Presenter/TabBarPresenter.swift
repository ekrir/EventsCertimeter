//
//  TabBarPresenter.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import Foundation
import UIKit
import MapKit
import CoreData

struct TabBarItem {
    let title: String
    let tabBarTitle: String
    let tabBarImage: UIImage
    let viewController: UIViewController
}

class TabBarPresenter: NSObject {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let context = PersistenceController.shared.container.viewContext
    //MARK: - TabBar
    func start(_ window: UIWindow){
        
        
        let tabBarView = storyboard.instantiateViewController(identifier: "TabBarViewStoryboard") as TabBarView
        //        var tabBarView = TabBarView()
        
        
        tabBarView.delegate = self
        
        let vc = getViewController()
        tabBarView.setViewControllers(vc.compactMap({
            return UINavigationController(rootViewController: $0.viewController)
        }), animated: true)
        
        guard let tabBarItem = tabBarView.tabBar.items else {return}
        for i in 0..<tabBarItem.count {
            tabBarItem[i].title = vc[i].tabBarTitle
            tabBarItem[i].image = vc[i].tabBarImage
        }
        
        
        window.rootViewController = tabBarView
        window.makeKeyAndVisible()
        
    }
    fileprivate func getViewController()-> [TabBarItem]{
        var vc: [TabBarItem] = []
        
        vc.append(.init(title: "Mappa degli Eventi", tabBarTitle: "Mappa", tabBarImage: UIImage(systemName: "map") ?? UIImage(), viewController: getMapVc()))
        vc.append(.init(title: "Lista degli Eventi", tabBarTitle: "Lista", tabBarImage: UIImage(systemName: "list.bullet") ?? UIImage(), viewController: getEventListVC()))
        return vc
    }
    //MARK: - inizializzazione pagine della tabBar
    fileprivate func getMapVc() -> UIViewController{
        let vc = storyboard.instantiateViewController(identifier: "MappaTabViewController") as? MappaTabView
        vc?.delegate = self
        return vc ?? UIViewController()
        
    }
    fileprivate func getEventListVC() -> UIViewController{
        let vc = storyboard.instantiateViewController(identifier: "ListaTabViewController") as? EventListView
        vc?.delegate = self
        let iMieiEventi = getMyEvent()
        let altriEventi = getOtherEvent().filter({value in
            return value.visibile && !iMieiEventi.contains(where: {$0.id == value.id}) })
        print(altriEventi)
        vc?.configure(myEvents: iMieiEventi, otherEvents: altriEventi)
        return vc ?? UIViewController()
    }
    
    func getMyEvent() -> [Evento]{
        var fetchRequestEventFromPerona: NSFetchRequest<Persona>
        fetchRequestEventFromPerona = Persona.fetchRequest()
        fetchRequestEventFromPerona.predicate = NSPredicate(format: "nomeCompleto == %@", "Gianluca Ferrosi")
        let persona = try? context.fetch(fetchRequestEventFromPerona)
        let firstPersona = persona?.first
        
        var fetchRequestEventFromRelationship: NSFetchRequest<Evento>
        fetchRequestEventFromRelationship = Evento.fetchRequest()
        fetchRequestEventFromRelationship.predicate = NSPredicate(format: "(ANY fromPersona == %@)", firstPersona!)
        return (try? context.fetch(fetchRequestEventFromRelationship)) ?? []
        
    }
            
    func getOtherEvent() -> [Evento]{
        var fetchRequestEvents: NSFetchRequest<Evento>
        fetchRequestEvents = Evento.fetchRequest()
        return (try? context.fetch(fetchRequestEvents)) ?? []

    }
    
}

extension TabBarPresenter: UITabBarControllerDelegate{
    
}
//MARK: - delegati mappa
extension TabBarPresenter: MappaTabViewDelegate{
    func didTapOnFiltra(_ navigationController: UINavigationController) {
        
        let vc = storyboard.instantiateViewController(identifier: "FiltraViewController")
        vc.title = "Filtra"
        navigationController.pushViewController(vc, animated: true)
        
    }
}



extension TabBarPresenter: MKMapViewDelegate{
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView(annotation: MKAnnotation?, reuseIdentifier: <#T##String?#>)]) {
//        <#code#>
//    }
}


//MKAnnotationView



//MARK: - delegati lista
extension TabBarPresenter: EventListViewDelegate{
    func didTapOnNewEvent(navController: UINavigationController) {
        let newEventPresenter = NewEventPresenter()
        newEventPresenter.start(navcontroller: navController)
    }
}

