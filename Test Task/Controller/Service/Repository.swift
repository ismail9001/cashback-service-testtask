//
//  Repository.swift
//  Test Task
//
//  Created by macbook on 10.02.2021.
//

import Foundation
import CoreData
import SwiftyJSON

final class Repository {
    
    let coreData = CoreDataService.shared
    let notificationCenter = NotificationCenter.default
    var observe: (([TestData]) -> Void)? {
        didSet {
            observe?(getData())
        }
    }
    
    init() {
        notificationCenter.addObserver(self, selector: #selector(contextObjectDidChanged), name: NSNotification.Name.NSManagedObjectContextObjectsDidChange, object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    func getData() -> [TestData] {
        
        let entityName = String(describing: TestData.self)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let sort = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        let fetchedObjects = try? coreData.context.fetch(fetchRequest) as? [TestData]
        return fetchedObjects ?? []
    }
    
    func addData(json: JSON) {
        let entityName = String(describing: TestData.self)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: coreData.context)
        for (_, object) in json{
            let testData = TestData(entity: entity!, insertInto: coreData.context)
            testData.setValue(object["id"].numberValue, forKey: "id")
            testData.setValue(object["albumId"].numberValue, forKey: "albumId")
            testData.setValue(object["title"].stringValue, forKey: "title")
            testData.setValue(object["thumbnailUrl"].stringValue, forKey: "thumbnailUrl")
            testData.setValue(object["url"].stringValue, forKey: "url")
        }
        coreData.saveContext()
    }
    
    func deleteData(_ data: [TestData]) {
        data.forEach{ coreData.context.delete($0) }
        coreData.saveContext()
    }
    
    @objc private func contextObjectDidChanged(_ notification: Notification) {
        if let insertedObjects = notification.userInfo?[NSInsertedObjectsKey] as? Set<NSManagedObject>, !insertedObjects.isEmpty {
            observe?(getData())
        }
    }
}
