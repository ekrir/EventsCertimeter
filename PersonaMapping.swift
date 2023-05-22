//
//  PersonaMapping.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 22/05/23.
//

import Foundation
import CoreData

class PersonaMapping: NSEntityMigrationPolicy{
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        let personaName = sInstance.primitiveValue(forKey: "nomeCompleto") as! String
        let personaEta = sInstance.primitiveValue(forKey: "eta") as! String
        let persona = NSEntityDescription.insertNewObject(forEntityName: "Persona", into: manager.destinationContext)
        persona.setValue(personaName, forKey: "nomeCompleto")
        persona.setValue(Int(personaEta), forKey: "eta")
    }
}
