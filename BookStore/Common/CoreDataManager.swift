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
    
    // 코어데이터에서 추출한 데이터 저장하는 배열
    var bookEntityData: [BookEntity] = []
    
    // 코어데이터 저장소
    let persistentContainer: NSPersistentContainer
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (StoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // 코어데이터 저장소 공간
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 코어데이터 저장하기
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
    
    // Create 쓰기
    func create(data: BookData.Documents) {
        let BookEntityData = BookEntity(context: context)
        BookEntityData.title = data.title
        BookEntityData.author = data.authors.joined(separator: ",")
        BookEntityData.thumbnail = data.thumbnail
        BookEntityData.price = Int64(data.price)
        BookEntityData.content = data.contents
        
        saveContext()
    }
    
    // Read 읽기
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
    
    // Delete 데이터 삭제
    func delete(data: BookEntity) {
        context.delete(data)
        saveContext()
    }
    
    // 전체 데이터 삭제
    func deleteAllBooks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = BookEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest) // 대량 데이터 삭제 시, 사용

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("모든 BookEntity 삭제 완료")
        } catch {
            print("전체 삭제 실패: \(error)")
        }
    }
}
