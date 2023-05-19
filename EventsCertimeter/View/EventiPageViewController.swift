//
//  EvventiPageViewController.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 18/05/23.
//

import UIKit

protocol EventiPageViewControllerDelegate{
    func tapApplicaEvento(evento: Evento)
}

class EventiPageViewController: UIPageViewController {
    private var listaEventi: [Evento] = []
    private var selectedIndex: Int = 0
    private var showPulsante: Bool = false
    var saveDelegate: EventiPageViewControllerDelegate?
    let storyboardMio = UIStoryboard(name: "Main", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func configre(eventi: [Evento], index: Int, showPulsante: Bool){
        self.showPulsante = showPulsante
        listaEventi = eventi
        selectedIndex = index
        self.setViewControllers([getViewForIndex()], direction: .forward, animated: true)
    }
    
    func getViewForIndex() -> UIViewController{
        
        let vc = storyboardMio.instantiateViewController(identifier: "SingoloEventoPageViewController") as? SingoloEventoPageViewController
        vc?.singoloEventoDelegate = self
        vc?.configure(evento: listaEventi[selectedIndex], showPulsante: showPulsante)
        return vc ?? UIViewController()
    }

}

extension EventiPageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if selectedIndex > 0 {
            selectedIndex -= 1
            return getViewForIndex()
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if selectedIndex < listaEventi.count - 1{
            selectedIndex += 1
            return getViewForIndex()
        }
        return nil
    }
    
    
}

extension EventiPageViewController: SingoloEventoPageViewControllerDelegate{
    func didTapOnApplicaEvento(evento: Evento) {
        saveDelegate?.tapApplicaEvento(evento: evento)
        if let indiceElemento = listaEventi.firstIndex(of: evento){
            listaEventi.remove(at: indiceElemento)
            if listaEventi.isEmpty{
                self.navigationController?.popViewController(animated: true)
            }else if indiceElemento == listaEventi.count{
                selectedIndex = listaEventi.count - 1
                self.setViewControllers([getViewForIndex()], direction: .reverse, animated: true)
            }else{
                self.setViewControllers([getViewForIndex()], direction: .forward, animated: true)
            }
        }
    }
    
    
}
