//
//  PersistenceController.swift
//  Bucket
//
//  Created by Joel Ward on 11/13/24.
//


import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        // Create sample data for previews if needed
        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model") // Replace with your model name
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Handle the error appropriately in production
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
