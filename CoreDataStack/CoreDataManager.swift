//
//  CoreDataManager.swift
//  CoreDataStack
//
//  Created by Bart Jacobs on 17/07/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import CoreData
import Foundation

open class CoreDataManager {

    fileprivate let modelName: String

    init(modelName: String) {
        self.modelName = modelName
    }

    // MARK: - Core Data Stack

    open fileprivate(set) lazy var mainManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.parent = self.privateManagedObjectContext

        return managedObjectContext
    }()

    fileprivate lazy var privateManagedObjectContext: NSManagedObjectContext = {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator

        return managedObjectContext
    }()

    fileprivate lazy var managedObjectModel: NSManagedObjectModel? = {
        // Fetch Model URL
        guard let modelURL = Bundle.main.url(forResource: self.modelName, withExtension: "momd") else {
            return nil
        }

        // Initialize Managed Object Model
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)

        return managedObjectModel
    }()

    fileprivate lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = self.managedObjectModel else {
            return nil
        }

        // Helper
        let persistentStoreURL = self.persistentStoreURL

        // Initialize Persistent Store Coordinator
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)

        do {
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true ]
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: options)

        } catch {
            let addPersistentStoreError = error as NSError

            print("Unable to Add Persistent Store")
            print("\(addPersistentStoreError.localizedDescription)")
        }

        return persistentStoreCoordinator
    }()

    // MARK: - Computed Properties

    fileprivate var persistentStoreURL: URL {
        // Helpers
        let storeName = "\(modelName).sqlite"
        let fileManager = FileManager.default

        let documentsDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

        return documentsDirectoryURL.appendingPathComponent(storeName)
    }

    // MARK: - Helper Methods

    open func saveChanges() {
        mainManagedObjectContext.performAndWait({
            do {
                if self.mainManagedObjectContext.hasChanges {
                    try self.mainManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Main Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        })

        privateManagedObjectContext.perform({
            do {
                if self.privateManagedObjectContext.hasChanges {
                    try self.privateManagedObjectContext.save()
                }
            } catch {
                let saveError = error as NSError
                print("Unable to Save Changes of Private Managed Object Context")
                print("\(saveError), \(saveError.localizedDescription)")
            }
        })
    }

    open func privateChildManagedObjectContext() -> NSManagedObjectContext {
        // Initialize Managed Object Context
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)

        // Configure Managed Object Context
        managedObjectContext.parent = mainManagedObjectContext

        return managedObjectContext
    }

}
