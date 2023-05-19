//
//  SceneDelegate.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 12/05/23.
//

import UIKit
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let win = UIWindow(windowScene: windowScene)
        mockDati()
        self.window = win
        let tabBarP = TabBarPresenter()
        tabBarP.start(win)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }

    func mockDati(){
        let context = PersistenceController.shared.container.viewContext
        let requestEventi = Evento.request()
        let deleteRequestEventi = NSBatchDeleteRequest(fetchRequest: requestEventi)
        let requestPersone = Persona.request()
        let deleteRequestPersone = NSBatchDeleteRequest(fetchRequest: requestPersone)
        
        do {
            guard let persistentStoreCoordinator =
                    context.persistentStoreCoordinator else { return }
            
            try persistentStoreCoordinator
                .execute(deleteRequestEventi, with: context)
            try persistentStoreCoordinator
                .execute(deleteRequestPersone, with: context)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    
        
        let evento1 = Evento(context: context)
        evento1.nomeEvento = "Sconti dal doc"
        evento1.dataInizio = Date().mezzanotte
        evento1.dataFine = Calendar.current.date(byAdding: .day, value: 1, to: Date().mezzanotte) ?? Date().mezzanotte
        evento1.descrizione = "solo per oggi sconti dal doc"
        evento1.luogo = "via aaa 27"
        evento1.prezzo = 5.00
        evento1.visibile = true
        evento1.latitudine = 45.087600
        evento1.longitudine = 7.657611
        
        let evento2 = Evento(context: context)
        evento2.nomeEvento = "cinema con gli amici"
        evento2.dataInizio = Calendar.current.date(byAdding: .hour, value: 20, to: Date().mezzanotte) ?? Date().mezzanotte
        evento2.dataFine = Calendar.current.date(byAdding: .hour, value: 23, to: Date().mezzanotte) ?? Date().mezzanotte
        evento2.descrizione = "solo per oggi sconti dal doc"
        evento2.luogo = "via bbb 42"
        evento2.prezzo = 11.00
        evento2.visibile = false
        evento2.latitudine = 45.087011
        evento2.longitudine = 7.667893
        
        let evento3 = Evento(context: context)
        evento3.nomeEvento = "mc friday"
        evento3.dataInizio = Date().mezzanotte
        evento3.dataFine = Calendar.current.date(byAdding: .day, value: 1, to: Date().mezzanotte) ?? Date().mezzanotte
        evento3.descrizione = "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"
        evento3.luogo = "via ccc 94"
        evento3.prezzo = 5.00
        evento3.visibile = true
        evento3.latitudine = 45.087721
        evento3.longitudine = 7.657611
        
        let persona1 = Persona(context: context)
        persona1.nomeCompleto = "Gianluca Ferrosi"
        persona1.toEvento = [evento2]
        
        let persona2 = Persona(context: context)
        persona2.nomeCompleto = "Pietro Nuset"
        
        try? context.save()
    }
    

}

