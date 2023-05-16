//
//  Persona+CoreDataProperties.swift
//  EventsCertimeter
//
//  Created by Michel Di Pietro on 16/05/23.
//
//

import Foundation
import CoreData


extension Persona {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Persona> {
        return NSFetchRequest<Persona>(entityName: "Persona")
    }
    
    static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request: NSFetchRequest<NSFetchRequestResult> =
        NSFetchRequest(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsObjectsAsFaults = true
        return request
    }

    @NSManaged public var nomeCompleto: String?
    @NSManaged public var toEvento: NSOrderedSet?
    @NSManaged public var toPersona: NSOrderedSet?
    @NSManaged public var fromPersona: NSOrderedSet?

}

// MARK: Generated accessors for toEvento
extension Persona {

    @objc(insertObject:inToEventoAtIndex:)
    @NSManaged public func insertIntoToEvento(_ value: Evento, at idx: Int)

    @objc(removeObjectFromToEventoAtIndex:)
    @NSManaged public func removeFromToEvento(at idx: Int)

    @objc(insertToEvento:atIndexes:)
    @NSManaged public func insertIntoToEvento(_ values: [Evento], at indexes: NSIndexSet)

    @objc(removeToEventoAtIndexes:)
    @NSManaged public func removeFromToEvento(at indexes: NSIndexSet)

    @objc(replaceObjectInToEventoAtIndex:withObject:)
    @NSManaged public func replaceToEvento(at idx: Int, with value: Evento)

    @objc(replaceToEventoAtIndexes:withToEvento:)
    @NSManaged public func replaceToEvento(at indexes: NSIndexSet, with values: [Evento])

    @objc(addToEventoObject:)
    @NSManaged public func addToToEvento(_ value: Evento)

    @objc(removeToEventoObject:)
    @NSManaged public func removeFromToEvento(_ value: Evento)

    @objc(addToEvento:)
    @NSManaged public func addToToEvento(_ values: NSOrderedSet)

    @objc(removeToEvento:)
    @NSManaged public func removeFromToEvento(_ values: NSOrderedSet)

}

// MARK: Generated accessors for toPersona
extension Persona {

    @objc(insertObject:inToPersonaAtIndex:)
    @NSManaged public func insertIntoToPersona(_ value: Persona, at idx: Int)

    @objc(removeObjectFromToPersonaAtIndex:)
    @NSManaged public func removeFromToPersona(at idx: Int)

    @objc(insertToPersona:atIndexes:)
    @NSManaged public func insertIntoToPersona(_ values: [Persona], at indexes: NSIndexSet)

    @objc(removeToPersonaAtIndexes:)
    @NSManaged public func removeFromToPersona(at indexes: NSIndexSet)

    @objc(replaceObjectInToPersonaAtIndex:withObject:)
    @NSManaged public func replaceToPersona(at idx: Int, with value: Persona)

    @objc(replaceToPersonaAtIndexes:withToPersona:)
    @NSManaged public func replaceToPersona(at indexes: NSIndexSet, with values: [Persona])

    @objc(addToPersonaObject:)
    @NSManaged public func addToToPersona(_ value: Persona)

    @objc(removeToPersonaObject:)
    @NSManaged public func removeFromToPersona(_ value: Persona)

    @objc(addToPersona:)
    @NSManaged public func addToToPersona(_ values: NSOrderedSet)

    @objc(removeToPersona:)
    @NSManaged public func removeFromToPersona(_ values: NSOrderedSet)

}

// MARK: Generated accessors for fromPersona
extension Persona {

    @objc(insertObject:inFromPersonaAtIndex:)
    @NSManaged public func insertIntoFromPersona(_ value: Persona, at idx: Int)

    @objc(removeObjectFromFromPersonaAtIndex:)
    @NSManaged public func removeFromFromPersona(at idx: Int)

    @objc(insertFromPersona:atIndexes:)
    @NSManaged public func insertIntoFromPersona(_ values: [Persona], at indexes: NSIndexSet)

    @objc(removeFromPersonaAtIndexes:)
    @NSManaged public func removeFromFromPersona(at indexes: NSIndexSet)

    @objc(replaceObjectInFromPersonaAtIndex:withObject:)
    @NSManaged public func replaceFromPersona(at idx: Int, with value: Persona)

    @objc(replaceFromPersonaAtIndexes:withFromPersona:)
    @NSManaged public func replaceFromPersona(at indexes: NSIndexSet, with values: [Persona])

    @objc(addFromPersonaObject:)
    @NSManaged public func addToFromPersona(_ value: Persona)

    @objc(removeFromPersonaObject:)
    @NSManaged public func removeFromFromPersona(_ value: Persona)

    @objc(addFromPersona:)
    @NSManaged public func addToFromPersona(_ values: NSOrderedSet)

    @objc(removeFromPersona:)
    @NSManaged public func removeFromFromPersona(_ values: NSOrderedSet)

}

extension Persona : Identifiable {

}
