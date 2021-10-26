//
//  CoreDataManager.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 1.10.21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let sharedManager = CoreDataManager()
    private init() {}
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RSSchool_T12")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    var contextHasChanges: Bool {
        get {
            return managedContext.hasChanges
        }
    }
    
    func saveContext() {
        if managedContext.hasChanges {
            do {
                try managedContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func cancelChanges() {
        managedContext.rollback()
    }
    
    func getObject(_ objectId: NSManagedObjectID) -> NSManagedObject? {
        var object: NSManagedObject?
        do {
            object = try CoreDataManager.sharedManager.managedContext.existingObject(with: objectId)
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return object
    }
    
    func deleteObject(_ object: NSManagedObject) {
        managedContext.delete(object)
        saveContext()
    }
}
