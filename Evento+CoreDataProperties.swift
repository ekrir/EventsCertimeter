//
//  Evento+CoreDataProperties.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 16/05/23.
//
//

import Foundation
import CoreData


extension Evento {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Evento> {
        return NSFetchRequest<Evento>(entityName: "Evento")
    }
    static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }

    @NSManaged public var dataFine: Date
    @NSManaged public var dataInizio: Date
    @NSManaged public var descrizione: String?
    @NSManaged public var latitudine: Double
    @NSManaged public var longitudine: Double
    @NSManaged public var luogo: String?
    @NSManaged public var nomeEvento: String?
    @NSManaged public var prezzo: Double
    @NSManaged public var visibile: Bool
    @NSManaged public var fromPersona: NSOrderedSet?

}

// MARK: Generated accessors for frompPersona
extension Evento {

    @objc(insertObject:inFrompPersonaAtIndex:)
    @NSManaged public func insertIntoFrompPersona(_ value: Persona, at idx: Int)

    @objc(removeObjectFromFrompPersonaAtIndex:)
    @NSManaged public func removeFromFrompPersona(at idx: Int)

    @objc(insertFrompPersona:atIndexes:)
    @NSManaged public func insertIntoFrompPersona(_ values: [Persona], at indexes: NSIndexSet)

    @objc(removeFrompPersonaAtIndexes:)
    @NSManaged public func removeFromFrompPersona(at indexes: NSIndexSet)

    @objc(replaceObjectInFrompPersonaAtIndex:withObject:)
    @NSManaged public func replaceFrompPersona(at idx: Int, with value: Persona)

    @objc(replaceFrompPersonaAtIndexes:withFrompPersona:)
    @NSManaged public func replaceFrompPersona(at indexes: NSIndexSet, with values: [Persona])

    @objc(addFrompPersonaObject:)
    @NSManaged public func addToFrompPersona(_ value: Persona)

    @objc(removeFrompPersonaObject:)
    @NSManaged public func removeFromFrompPersona(_ value: Persona)

    @objc(addFrompPersona:)
    @NSManaged public func addToFrompPersona(_ values: NSOrderedSet)

    @objc(removeFrompPersona:)
    @NSManaged public func removeFromFrompPersona(_ values: NSOrderedSet)

}

extension Evento : Identifiable {

}
