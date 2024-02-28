//
//  OrderRepository.swift
//  MobileAppTest
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import Foundation
import SQLite3

class OrderRepository{
    
    static func insertOrder(db: OpaquePointer?, username: String, address: String, number: String, food: String) {
           guard let db = db else {
               print("Database pointer is nil")
               return
           }

           let insertSQL = "INSERT INTO orders (username, address, number, food) VALUES (?, ?, ?, ?)"
           var statement: OpaquePointer? = nil

           if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
               let cStringUsername = username.cString(using: .utf8)
               let cStringAddress = address.cString(using: .utf8)
               let cStringNumber = number.cString(using: .utf8)
               let cStringFood = food.cString(using: .utf8)
               
               sqlite3_bind_text(statement, 1, cStringUsername, -1, nil)
               sqlite3_bind_text(statement, 2, cStringAddress, -1, nil)
               sqlite3_bind_text(statement, 3, cStringNumber, -1, nil)
               sqlite3_bind_text(statement, 4, cStringFood, -1, nil)

               if sqlite3_step(statement) == SQLITE_DONE {
                   print("Successfully inserted order")
               } else {
                   let errorMessage = String(cString: sqlite3_errmsg(db))
                   print("Error inserting order: \(errorMessage)")
               }
           } else {
               let errorMessage = String(cString: sqlite3_errmsg(db))
               print("Error preparing insert statement: \(errorMessage)")
           }

           sqlite3_finalize(statement)
       }
}
