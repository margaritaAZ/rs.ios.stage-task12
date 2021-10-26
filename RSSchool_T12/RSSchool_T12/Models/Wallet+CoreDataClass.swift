//
//  Wallet+CoreDataClass.swift
//  RSSchool_T12
//
//  Created by Маргарита Жучик on 30.09.21.
//
//

import Foundation
import CoreData

@objc(Wallet)
public class Wallet: NSManagedObject {
    var balance: Float {
        get {
            if let transactions = transactions?.allObjects as? [Transaction] {
                return transactions.map({$0.value}).reduce(0, +)
            } else {
                return 0
            }
        }
    }
}
