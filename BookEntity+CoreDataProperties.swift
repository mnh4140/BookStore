//
//  BookEntity+CoreDataProperties.swift
//  BookStore
//
//  Created by NH on 5/13/25.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var price: Int64
    @NSManaged public var thumbnail: String?
    @NSManaged public var title: String?

}

extension BookEntity : Identifiable {

}
