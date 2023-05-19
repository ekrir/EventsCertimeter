//
//  NewEventPresenter.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import Foundation
import UIKit
import CoreData
protocol NewEventPresenterDelegate{
    func inRitornoDaNuovoEvento()
}

class NewEventPresenter{
    let storyboard = UIStoryboard(name: "NewEvent", bundle: nil)
    let dateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.AAAA hh.mm"
        return f
    }()
    
    var navigationDelegate: NewEventPresenterDelegate?
    
    
    
    func start(navcontroller: UINavigationController){
        let vc = storyboard.instantiateViewController(withIdentifier: "CompilaNuovoEvento") as? CompilaNuovoEvento
        vc?.delegate = self
        navcontroller.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

extension NewEventPresenter: CompilaNuovoEventoDelegate{
    func didTapOnQRCode(_ navController: UINavigationController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "QRCodeScannerView") as? QRCodeScannerView
        vc?.title = "scanneriza il qr"
        navController.pushViewController(vc ?? UIViewController(), animated: true)
    }
    
    func didTapOnCercaPosizione(_ navController: UINavigationController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "SelezionaPosizioneView") as? SelezionaPosizioneView
        navController.pushViewController(vc ?? UIViewController(), animated: true)
        print(vc != nil )
    }
    
    func didTapOnSalva() {
        //TODO: - spostare fuori nell'inizializzazione del tutto
        
        var context = PersistenceController.shared.container.viewContext
        // faccio una prova per mettere sotto stress il db
        
        for i in 0...50 {
            let newEvento = Evento(context: context)
            newEvento.nomeEvento = "evento \(i)"
            newEvento.dataInizio = Calendar.current.date(byAdding: .day, value: i, to: Date().mezzanotte) ?? Date()
            newEvento.dataFine = Calendar.current.date(bySetting: .day, value: i + 1, of: Date()) ?? Date()
            newEvento.latitudine = 45.088600 + (Double(i) * 0.001)
            newEvento.longitudine = 7.658611 + (Double(i) * 0.001)
            newEvento.luogo = "via test \(i + 1)"
            newEvento.descrizione = "solo per oggi sconti dal doc"
            newEvento.prezzo = 5.00
            newEvento.visibile = true
            do{
                try context.save()
            }catch{
                print("errore a \(i)")
            }
            
            
        }
        navigationDelegate?.inRitornoDaNuovoEvento()
    }
    
    func didTapOnSelezionaDataInizio(_ viewController: UIViewController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "SelezionaDataView") as? SelezionaDataView
        vc?.modalPresentationStyle = .formSheet
        vc?.preferredContentSize.height = 200
        guard let selezionadata = vc else {return}
        selezionadata.preferredContentSize.height = 200

        viewController.present(selezionadata, animated: true)
    }
    
    func didTapOnSelezionaDataFine(_ navController: UINavigationController) {
        let vc = storyboard.instantiateViewController(withIdentifier: "SelezionaDataView") as? SelezionaDataView
        navController.pushViewController(vc ?? UIViewController(), animated: true)
    }
}

