//
//  CoreDataManager.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 1.10.21.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    var contextHasChanges: Bool { get }
    var managedContext: NSManagedObjectContext { get }
    func saveContext()
    func cancelChanges()
    func getObject(_ objectId: NSManagedObjectID) -> NSManagedObject?
    func deleteObject(_ object: NSManagedObject)
}

class CoreDataManager {
    let containerName: String
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.containerName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var managedContext: NSManagedObjectContext = { storeContainer.viewContext }()
    
    init(containerName: String) {
        self.containerName = containerName
    }
}

extension CoreDataManager: CoreDataManagerProtocol {
    var contextHasChanges: Bool { managedContext.hasChanges }
    
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
            object = try managedContext.existingObject(with: objectId)
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
