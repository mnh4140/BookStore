//
//  RecentBookEntity+CoreDataProperties.swift
//  BookStore
//
//  Created by NH on 5/13/25.
//
//

import Foundation
import CoreData


extension RecentBookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentBookEntity> {
        return NSFetchRequest<RecentBookEntity>(entityName: "RecentBookEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var author: String?
    @NSManaged public var content: String?
    @NSManaged public var price: Int64
    @NSManaged public var insertDate: Date?

}

extension RecentBookEntity : Identifiable {

}
