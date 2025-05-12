//
//  CoreDataModel.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager(modelName: "BookStore")
    
    var bookEntityData: [BookEntity] = []
    
    let persistentContainer: NSPersistentContainer
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (StoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetch() {
        let fetchRequest: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        
        do {
            bookEntityData = try self.context.fetch(fetchRequest)
            // 디버그
            print("저장된 책 목록:")
                    for book in bookEntityData {
                        let title = book.title ?? "제목 없음"
                        let author = book.author ?? "저자 없음"
                        let price = book.price
                        let content = book.content ?? "내용 없음"
                        let thumbnail = book.thumbnail ?? "썸네일 없음"
                        
                        print("""
                        ------------------------
                        제목: \(title)
                        저자: \(author)
                        가격: \(price)원
                        내용: \(content.prefix(50))...
                        썸네일: \(thumbnail)
                        ------------------------
                        """)
                    }
        } catch {
            print("Failed to fetch contacts: \(error)")
        }
    }
    
    func create(data: BookData.Documents) {
        let BookEntityData = BookEntity(context: context)
        BookEntityData.title = data.title
        BookEntityData.author = data.authors.joined(separator: ",")
        BookEntityData.thumbnail = data.thumbnail
        BookEntityData.price = Int32(data.price)
        BookEntityData.content = data.contents
        
        saveContext()
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
