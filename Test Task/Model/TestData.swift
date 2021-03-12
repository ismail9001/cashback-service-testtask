//
//  TestData.swift
//  Test Task
//
//  Created by macbook on 10.02.2021.
//

import CoreData

@objc(TestData)
final class TestData: NSManagedObject {
    
    @NSManaged var albumId: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var title: String
    @NSManaged var url: String
    @NSManaged var thumbnailUrl: String
    
}
