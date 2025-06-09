//
//  CoreDataHelper+Search.swift
//  AppStoreSearch
//
//  Created by HYUN SUNG on 9/14/24.
//

import CoreData

extension CoreDataHelper {
    struct search {
        fileprivate static let entityName: String = "KeywordHistory"
        static var entity = NSEntityDescription.entity(
            forEntityName: CoreDataHelper.search.entityName,
            in: CoreDataHelper.shared.managedObjectContext
        )
        fileprivate struct add { }
        fileprivate struct delete { }
        fileprivate struct load { }
        struct action { }
    }
}
extension CoreDataHelper.search.action {
    static func loadKeywordHistory() -> [String] {
        return CoreDataHelper.search.load.loadKeywordHistory()?
            .compactMap { $0 as? NSManagedObject }
            .compactMap { $0.value(forKey: "keyword") as? String } ?? []
    }
    
    static func addSearchKeyword(keyword: String?) {
        guard let keyword = keyword,
              !keyword.isEmpty else { return }
        CoreDataHelper.search.add.addSearchKeyword(keyword: keyword)
    }
}

// MARK: - Add
private extension CoreDataHelper.search.add {
    static func addSearchKeyword(keyword: String) {
        let fetchRequestList = NSFetchRequest<NSFetchRequestResult>(
            entityName: CoreDataHelper.search.entityName
        )
        guard let entity = CoreDataHelper.search.entity else { return }
        fetchRequestList.entity = entity
        
        let predicate = NSPredicate(format: "keyword == %@", keyword)
        fetchRequestList.predicate = predicate
        
        do {
            let fetchResults = try CoreDataHelper.shared.managedObjectContext.fetch(fetchRequestList) as? [NSManagedObject]
            if fetchResults?.count != 0 {
                fetchResults?.first?.setValue(Date(), forKey: "date" )
                
                try CoreDataHelper.shared.managedObjectContext.save()
            } else {
                
                let recentInfo = NSManagedObject(
                    entity: entity,
                    insertInto: CoreDataHelper.shared.managedObjectContext
                )
                
                recentInfo.setValue(keyword, forKey: "keyword")
                recentInfo.setValue(Date(), forKey: "date" )
                
                try CoreDataHelper.shared.managedObjectContext.save()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

// MARK: - Load
private extension CoreDataHelper.search.load {
    static func loadKeywordHistory() -> [AnyObject]? {
        let fetchRequestList = NSFetchRequest<NSFetchRequestResult>(
            entityName: CoreDataHelper.search.entityName
        )
        guard let entity = CoreDataHelper.search.entity else { return nil }
        
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequestList.sortDescriptors = sortDescriptors
        fetchRequestList.entity = entity
        
        do {
            return try CoreDataHelper.shared.managedObjectContext.fetch(fetchRequestList)
        } catch {
            print("coredata context saving \(error.localizedDescription)")
            return nil
        }
    }
}
