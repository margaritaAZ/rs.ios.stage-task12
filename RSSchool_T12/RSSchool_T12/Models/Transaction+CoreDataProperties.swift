//
//  Transaction+CoreDataProperties.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 8.10.21.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var value: Float
    @NSManaged public var wallet: Wallet?

}

extension Transaction : Identifiable {

}
