//
//  CoreDataSensitiveModel+CoreDataProperties.swift
//  iVictim
//
//  Created by Azzaro Mujic on 01/06/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension CoreDataSensitiveModel {

    @NSManaged var key: String?
    @NSManaged var data: String?

}
