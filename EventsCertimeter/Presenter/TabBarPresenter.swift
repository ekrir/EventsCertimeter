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
import CoreLocation

struct TabBarItem {
    let title: String
    let tabBarTitle: String
    let tabBarImage: UIImage
    let viewController: UIViewController
}

class TabBarPresenter: NSObject {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let context = PersistenceController.shared.container.viewContext
    
    var iMieiEventi: [Evento] = []
    var altriEventi: [Evento] = []
    
    private var mapViewController = UIViewController()
    private var tableViewControlelr = UIViewController()
    //MARK: - TabBar
    func start(_ window: UIWindow){
        
        
        iMieiEventi = getMyEvent()
        altriEventi = getOtherEvent().filter({value in
            return value.visibile && !iMieiEventi.contains(where: {$0.id == value.id}) })
        
        let tabBarView = storyboard.instantiateViewController(identifier: "TabBarViewStoryboard") as TabBarView
        //        var tabBarView = TabBarView()
        
        
        tabBarView.delegate = self
        
        mapViewController = getMapVc()
        tableViewControlelr = getEventListVC()
        
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
        
        vc.append(.init(title: "Mappa degli Eventi", tabBarTitle: "Mappa", tabBarImage: UIImage(systemName: "map") ?? UIImage(), viewController: mapViewController))
        vc.append(.init(title: "Lista degli Eventi", tabBarTitle: "Lista", tabBarImage: UIImage(systemName: "list.bullet") ?? UIImage(), viewController: tableViewControlelr))
        return vc
    }
    //MARK: - inizializzazione pagine della tabBar
    fileprivate func getMapVc() -> UIViewController{
        let vc = storyboard.instantiateViewController(identifier: "MappaTabViewController") as? MappaTabView
        vc?.delegate = self
        vc?.configure(annotations: getListaAnnotazioni())
        return vc ?? UIViewController()
        
    }
    fileprivate func getEventListVC() -> UIViewController{
        let vc = storyboard.instantiateViewController(identifier: "ListaTabViewController") as? EventListView
        vc?.delegate = self
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
    
    func getListaAnnotazioni() -> [MyPointAnnotation] {
        var ann: [MyPointAnnotation] = []
        for value in iMieiEventi{
            var annTemp = MyPointAnnotation( evento: value)
            annTemp.coordinate = CLLocationCoordinate2D(latitude: value.latitudine, longitude: value.longitudine)
            annTemp.title = value.nomeEvento
            annTemp.pinTintColor = .green
            ann.append(annTemp)
        }
        
        for value in altriEventi{
            var annTemp = MyPointAnnotation( evento: value)
            annTemp.coordinate = CLLocationCoordinate2D(latitude: value.latitudine, longitude: value.longitudine)
            annTemp.title = value.nomeEvento
            annTemp.pinTintColor = .blue
            ann.append(annTemp)
        }
        
        
        return ann
    }
    
}

extension TabBarPresenter: UITabBarControllerDelegate{
    
}
//MARK: - delegati mappa
extension TabBarPresenter: MappaTabViewDelegate{
    func didTapOnFiltra(_ navigationController: UINavigationController) {
        
        let vc = storyboard.instantiateViewController(identifier: "FiltraViewController") as? FiltraView
        guard let vc = vc else {return}
        vc.title = "Filtra"
        vc.delegate = self
        navigationController.pushViewController(vc, animated: true)
        
    }
}



//MKAnnotationView



//MARK: - delegati lista
extension TabBarPresenter: EventListViewDelegate{
    func didTapOnNewEvent(navController: UINavigationController) {
        let newEventPresenter = NewEventPresenter()
        newEventPresenter.start(navcontroller: navController)
    }
}

//MARK: - delegati filtr

extension TabBarPresenter: FiltraViewDelegate{
    func didTapOnApplica() {
        
        let filtra = Filtra.shared
        var listaRisultanteiMieiEventi: [Evento] = []
        var listaRisultanteAltriEventi: [Evento] = []

        if filtra.iMieiEventiToggle{
            listaRisultanteiMieiEventi.append(contentsOf: iMieiEventi)
        }
        
        if filtra.altriEventiToggle{
            listaRisultanteAltriEventi.append(contentsOf: altriEventi)
        }
        
        if filtra.dataToggleisActive{
            listaRisultanteiMieiEventi = listaRisultanteiMieiEventi.filter({$0.dataInizio <= filtra.dataValue && $0.dataFine >= filtra.dataValue})
            listaRisultanteAltriEventi = listaRisultanteAltriEventi.filter({$0.dataInizio <= filtra.dataValue && $0.dataFine >= filtra.dataValue})

        }
        
        if let prezzo = filtra.prezzo{
            listaRisultanteiMieiEventi = listaRisultanteiMieiEventi.filter({$0.prezzo <= prezzo})
            listaRisultanteAltriEventi = listaRisultanteAltriEventi.filter({$0.prezzo <= prezzo})

        }
        
        
        guard let mappaView = mapViewController as? MappaTabView else {return}
        mappaView.aggiornaAnnotazioni(annotations: getListaAnnotazioni(iMieiEventi: listaRisultanteiMieiEventi, altriEventi: listaRisultanteAltriEventi))
    }
    
    func getListaAnnotazioni(iMieiEventi: [Evento], altriEventi: [Evento]) -> [MyPointAnnotation] {
        var ann: [MyPointAnnotation] = []
        for value in iMieiEventi{
            var annTemp = MyPointAnnotation( evento: value)
            annTemp.coordinate = CLLocationCoordinate2D(latitude: value.latitudine, longitude: value.longitudine)
            annTemp.title = value.nomeEvento
            annTemp.pinTintColor = .green
            ann.append(annTemp)
        }
        
        for value in altriEventi{
            var annTemp = MyPointAnnotation( evento: value)
            annTemp.coordinate = CLLocationCoordinate2D(latitude: value.latitudine, longitude: value.longitudine)
            annTemp.title = value.nomeEvento
            annTemp.pinTintColor = .blue
            ann.append(annTemp)
        }
        
        
        return ann
    }
}
