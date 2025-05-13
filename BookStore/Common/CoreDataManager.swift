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
    public var recentBookEntityData: [RecentBookEntity] = []
    public var bookEntityData: [BookEntity] = []
    
    // 코어데이터 저장소
    private let persistentContainer: NSPersistentContainer
    
    private init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
        persistentContainer.loadPersistentStores { (StoreDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    // 코어데이터 저장소 공간
    private var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 코어데이터 저장하기
    private func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Create 쓰기
    public func create(data: BookData.Documents) {
        let bookEntityData = BookEntity(context: context)
        bookEntityData.title = data.title
        bookEntityData.author = data.authors.joined(separator: ",")
        bookEntityData.thumbnail = data.thumbnail
        bookEntityData.price = Int64(data.price)
        bookEntityData.content = data.contents
        
        saveContext()
    }
    
    // 최근책 용
//    public func createRecentBooks(data: BookData.Documents) {
//        let recentBookData = RecentBookEntity(context: context)
//        recentBookData.title = data.title
//        recentBookData.thumbnail = data.thumbnail
//        recentBookData.insertDate = Date()
//        
//        saveContext()
//    }
    
    // 최근책 저장 - 기존 중복 데이터 삭제 후 새로 저장
//    public func createRecentBooks(data: BookData.Documents) {
//        let fetchRequest: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
//        
//        // 중복 기준: 제목 + 썸네일
//        fetchRequest.predicate = NSPredicate(format: "title == %@ AND thumbnail", data.title, data.thumbnail)
//        fetchRequest.fetchLimit = 1
//        
//        do {
//            // 1. 기존 중복 데이터가 있다면 삭제
//            if let existing = try context.fetch(fetchRequest).first {
//                context.delete(existing)
//                print("기존 중복 데이터 삭제: \(existing.title ?? "제목 없음")")
//            }
//            
//            // 2. 새로 저장
//            let recentBookData = RecentBookEntity(context: context)
//            recentBookData.title = data.title
//            recentBookData.thumbnail = data.thumbnail
//            recentBookData.insertDate = Date()
//            
//            saveContext()
//            print("최근책 새로 저장: \(data.title)")
//            
//        } catch {
//            print("최근책 저장 중 오류 발생: \(error)")
//        }
//    }
    
    // 10개 이후로 오래된 데이터 제거
    public func createRecentBooks(data: BookData.Documents) {
        let fetchRequest: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
        
        // 중복 확인 (제목 기준)
        fetchRequest.predicate = NSPredicate(format: "title == %@ AND thumbnail == %@", data.title, data.thumbnail)
        fetchRequest.fetchLimit = 1

        do {
            // 중복된 책이 있다면 삭제
            if let existing = try context.fetch(fetchRequest).first {
                context.delete(existing)
            }

            // 새로운 책 저장
            let recentBook = RecentBookEntity(context: context)
            recentBook.title = data.title
            recentBook.thumbnail = data.thumbnail
            recentBook.insertDate = Date()

            // 저장된 개수 확인 후 10개 초과하면 오래된 것 삭제
            let allFetch: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
            allFetch.sortDescriptors = [NSSortDescriptor(key: "insertDate", ascending: false)] // 최신순
            let allBooks = try context.fetch(allFetch)

            if allBooks.count > 10 {
                let booksToDelete = allBooks.suffix(from: 10) // 11번째 이후 오래된 것들
                for book in booksToDelete {
                    context.delete(book)
                }
            }

            saveContext()
            print("최근 책 저장 완료. 최신 10개 유지")

        } catch {
            print("최근 책 저장 오류")
        }
    }
    
    // MARK: - Read 읽기
    public func fetch() {
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
            print("저장된 책 목록 불러오기 실패")
        }
    }
    
    // 최근책 용
    public func fetchRecentBooks() {
        let fetchRequest: NSFetchRequest<RecentBookEntity> = RecentBookEntity.fetchRequest()
        
        // 저장일 기준 최신순 정렬 (나중에 저장한 게 먼저 나옴)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "insertDate", ascending: false)]
        
        do {
            recentBookEntityData = try self.context.fetch(fetchRequest)
            // 디버그
            print("저장된 책 목록:")
                    for book in recentBookEntityData {
                        let title = book.title ?? "제목 없음"
                        let thumbnail = book.thumbnail ?? "썸네일 없음"
                        
                        print("""
                        ------------------------
                        제목: \(title)
                        썸네일: \(thumbnail)
                        ------------------------
                        """)
                    }
        } catch {
            print("저장된 책 목록 불러오기 실패")
        }
    }
    
    // MARK: - Delete 데이터 삭제
    public func delete(data: BookEntity) {
        context.delete(data)
        saveContext()
    }
    
    // 전체 데이터 삭제
    public func deleteAllBooks() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = BookEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest) // 대량 데이터 삭제 시, 사용

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("모든 BookEntity 삭제 완료")
        } catch {
            print("전체 삭제 실패")
        }
    }
}
