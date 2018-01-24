//
//  Employee+CoreDataProperties.swift
//  FullCoreDataExample
//
//  Created by MOHIT SINGH on 24/01/18.
//  Copyright © 2018 MOHIT SINGH. All rights reserved.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var salary: Float
    @NSManaged public var address: String?

}
