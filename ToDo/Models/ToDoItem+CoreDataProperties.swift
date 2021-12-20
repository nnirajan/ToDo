//
//  ToDoItem+CoreDataProperties.swift
//  ToDo
//
//  Created by Nirajan Shrestha on 20/12/2021.
//
//

import Foundation
import CoreData


extension ToDoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoItem> {
        return NSFetchRequest<ToDoItem>(entityName: "ToDoItem")
    }

    @NSManaged public var checked: Bool
    @NSManaged public var title: String?
    @NSManaged public var id: String?

}

extension ToDoItem : Identifiable {

}
