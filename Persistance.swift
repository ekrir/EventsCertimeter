//
//  Persistance.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 16/05/23.
//

import Foundation
import CoreData

struct PersistenceController{
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false){
        container = NSPersistentContainer(name: "EventsCertimeter")
        if inMemory{
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: {
            (storedescription, error) in
            if let error = error as NSError? {
                fatalError("unresolved Error \(error)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
