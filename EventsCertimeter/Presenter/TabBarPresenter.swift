//
//  TabBarPresenter.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import Foundation
import UIKit
import MapKit

struct TabBarItem {
    let title: String
    let tabBarTitle: String
    let tabBarImage: UIImage
    let viewController: UIViewController
}

class TabBarPresenter: NSObject {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
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
    
    fileprivate func getMapVc() -> UIViewController{
        let vc = storyboard.instantiateViewController(identifier: "MappaTabViewController") as? MappaTabView
        vc?.delegate = self
        return vc ?? UIViewController()
        
    }
    fileprivate func getEventListVC() -> UIViewController{
        let vc = storyboard.instantiateViewController(identifier: "ListaTabViewController") as? EventListView
        vc?.delegate = self
        return vc ?? UIViewController()
    }
}

extension TabBarPresenter: UITabBarControllerDelegate{
    
}

extension TabBarPresenter: MappaTabViewDelegate{
    func didTapOnFiltra(_ navigationController: UINavigationController) {
        print("premito filra 2")
        
        let vc = storyboard.instantiateViewController(identifier: "FiltraViewController")
        vc.title = "Filtra"
        navigationController.pushViewController(vc, animated: true)
        
    }
}

extension TabBarPresenter: EventListViewDelegate{
    func didTapOnNewEvent(navController: UINavigationController) {
        let newEventPresenter = NewEventPresenter()
        newEventPresenter.start(navcontroller: navController)
    }
    
    
}

//extension TabBarPresenter: MKMapViewDelegate{
//    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView(annotation: MKAnnotation?, reuseIdentifier: <#T##String?#>)]) {
//        <#code#>
//    }
//}
//
//
//MKAnnotationView
//
