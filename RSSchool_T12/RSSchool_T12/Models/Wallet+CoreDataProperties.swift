//
//  Wallet+CoreDataProperties.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 8.10.21.
//
//

import Foundation
import CoreData


extension Wallet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Wallet> {
        return NSFetchRequest<Wallet>(entityName: "Wallet")
    }

    @NSManaged public var changeDate: Date?
    @NSManaged public var currencyCode: String?
    @NSManaged public var themeId: Int16
    @NSManaged public var title: String?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Wallet {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension Wallet : Identifiable {

}
