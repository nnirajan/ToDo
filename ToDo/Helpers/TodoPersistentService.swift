//
//  TodoPersistentService.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 20/12/2021.
//

import UIKit
import CoreData

class TodoPersistentService {
    
    static let shared = TodoPersistentService()
    
    // MARK: - persistentContainer
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - viewContext
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func fetch() -> [ToDoItem] {
        do {
            let items = try viewContext.fetch(ToDoItem.fetchRequest())
            return items
        } catch {
            fatalError("Failed to fetch, \(error.localizedDescription)")
        }
    }

    func save(item: TodoItemModel) {
        let newItem = ToDoItem(context: viewContext)
        newItem.id = item.id
        newItem.title = item.title
        newItem.checked = item.checked ?? false
        do {
            try viewContext.save()
        } catch {
            fatalError("Failed to save, \(error.localizedDescription)")
        }
    }
    
    func update(oldItem: ToDoItem, newItem: TodoItemModel) {
        oldItem.id = newItem.id
        oldItem.title = newItem.title
        oldItem.checked = newItem.checked ?? false
        do {
            try viewContext.save()
        } catch {
            fatalError("Failed to update, \(error.localizedDescription)")
        }
    }
    
}
