//
//  BookEntity+CoreDataProperties.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var price: Int32
    @NSManaged public var thumbnail: String?

}

extension BookEntity : Identifiable {

}
