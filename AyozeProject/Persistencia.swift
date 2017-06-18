//
//  Persistencia.swift
//  AyozeProject
//
//  Created by Loquat Solutions on 18/6/17.
//  Copyright © 2017 MHP. All rights reserved.
//

import Foundation


class Persitencia {

lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Supercars")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
        do {
            try context.save()
        } catch let error as NSError {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    }
}



}
