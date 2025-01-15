//
//  Persistence.swift
//  LCX-IOS-APP
//
//  Created by lcx001st on 2025/1/15.
//

import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "ChatApp")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data stack: \(error)")
            }
        }
    }

    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
}
