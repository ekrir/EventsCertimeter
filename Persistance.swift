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
    let container: NSPersistentContainer = {
        let internalContainer = NSPersistentContainer(name: "EventsCertimeter")
        internalContainer.loadPersistentStores(completionHandler: {
            (storeDescriprio, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }else {
                let description = NSPersistentStoreDescription()
                description.shouldMigrateStoreAutomatically = false
                description.shouldInferMappingModelAutomatically = true
                internalContainer.persistentStoreDescriptions = [description]
            }
        })
        return internalContainer
    } ()
        
        init(inMemory: Bool = false){
//        if inMemory{
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.persistentStoreDescriptions.first?.shouldMigrateStoreAutomatically = false
//        container.persistentStoreDescriptions.first?.shouldInferMappingModelAutomatically = true
//        container.loadPersistentStores(completionHandler: {
//            (storedescription, error) in
//            if let error = error as NSError? {
//                fatalError("unresolved Error \(error)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
