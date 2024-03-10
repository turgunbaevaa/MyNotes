//
//  Note+CoreDataProperties.swift
//  MyNotes
//
//  Created by Aruuke Turgunbaeva on 9/3/24.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var id: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: String?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
