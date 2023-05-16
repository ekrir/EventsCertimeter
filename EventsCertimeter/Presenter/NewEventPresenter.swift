//
//  NewEventPresenter.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 15/05/23.
//

import Foundation
import UIKit
class NewEventPresenter{
    let storyboard = UIStoryboard(name: "NewEvent", bundle: nil)
    let dateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "dd.MM.AAAA hh.mm"
        return f
    }()
    
    
    
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

