//
//  SignupRepository.swift
//  MobileAppTest
//
//  Created by THIS on 26.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import Foundation
import SQLite3
import CommonCrypto
import CryptoKit

class SignupRepository{
    

    static func insertUser(db: OpaquePointer?, username: String, password: String, email: String) {
        guard let db = db else {
            print("Database pointer is nil")
            return
        }

      

        let insertSQL = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)"
        var statement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            let cStringUsername = username.cString(using: .utf8)
            let cStringPassword = password.cString(using: .utf8)
            let cStringEmail = email.cString(using: .utf8)
            
            sqlite3_bind_text(statement, 1, cStringUsername, -1, nil)
            sqlite3_bind_text(statement, 2, cStringPassword, -1, nil)
            sqlite3_bind_text(statement, 3, cStringEmail, -1, nil)

            if sqlite3_step(statement) == SQLITE_DONE {
                print("Successfully inserted user")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("Error inserting user: \(errorMessage)")
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Error preparing insert statement: \(errorMessage)")
        }

        sqlite3_finalize(statement)
    }

       static func isUsernameExists(db: OpaquePointer?, username: String) -> Bool {
           let query = "SELECT COUNT(*) FROM users WHERE username = ?"
           var statement: OpaquePointer? = nil

           if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
               sqlite3_bind_text(statement, 1, username, -1, nil)

               if sqlite3_step(statement) == SQLITE_ROW {
                   let count = sqlite3_column_int(statement, 0)
                   return count > 0
               } else {
                   print("Error executing query: \(query)")
               }
           } else {
               print("Error preparing query statement: \(query)")
           }

           sqlite3_finalize(statement)
           return false
       }

       static func isEmailExists(db: OpaquePointer?, email: String) -> Bool {
           let query = "SELECT COUNT(*) FROM users WHERE email = ?"
           var statement: OpaquePointer? = nil

           if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
               sqlite3_bind_text(statement, 1, email, -1, nil)

               if sqlite3_step(statement) == SQLITE_ROW {
                   let count = sqlite3_column_int(statement, 0)
                   return count > 0
               } else {
                   print("Error executing query: \(query)")
               }
           } else {
               print("Error preparing query statement: \(query)")
           }

           sqlite3_finalize(statement)
           return false
       }
}
