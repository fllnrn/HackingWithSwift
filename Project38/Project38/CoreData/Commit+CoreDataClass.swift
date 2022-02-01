//
//  Commit+CoreDataClass.swift
//  Project38
//
//  Created by Андрей Гавриков on 31.01.2022.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    static private var count = 0
    override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        Commit.count = (Commit.count + 1) % Int.max
        print("Init called \(Commit.count)")
    }
}
