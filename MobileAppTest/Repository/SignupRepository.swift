//
//  SignupRepository.swift
//  MobileAppTest
//
//  Created by THIS on 26.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import Foundation
import SQLite3

class SignupRepository{
  
       static func insertUser(db: OpaquePointer?, username: String, password: String, email: String, salt: String) {
           guard let db = db else {
               print("Database pointer is nil")
               return
           }

           let insertSQL = "INSERT INTO users (username, password, email, salt) VALUES (?, ?, ?, ?)"

           var statement: OpaquePointer? = nil

           if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
               sqlite3_bind_text(statement, 1, username, -1, nil)
               sqlite3_bind_text(statement, 2, password, -1, nil)
               sqlite3_bind_text(statement, 3, email, -1, nil)
               sqlite3_bind_text(statement, 4, salt, -1, nil)

               if sqlite3_step(statement) == SQLITE_DONE {
                   print("Successfully inserted user")
               } else {
                   print("Error inserting user")
               }
           } else {
               print("Error preparing insert statement")
           }

           sqlite3_finalize(statement)
       }
       
      
//       static func addUserScores(db: OpaquePointer?) {
//           guard let db = db else {
//               print("Database pointer is nil")
//               return
//           }
//
//           let insertSQL = "INSERT INTO scores (easy) VALUES (?)"
//
//           var statement: OpaquePointer? = nil
//
//           if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
//               sqlite3_bind_int(statement, 1, 0) // your default value for easy score
//
//               if sqlite3_step(statement) == SQLITE_DONE {
//                   print("Successfully inserted user scores")
//               } else {
//                   print("Error inserting user scores")
//               }
//           } else {
//               print("Error preparing insert scores statement")
//           }
//
//           sqlite3_finalize(statement)
//       }

           
       //Metoda per validim gjate signup, se a ekziston ndonje username i njejte me ate te cilin deshiron te regjistrohet useri
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

       //Metoda per validim gjate signup, se a ekziston ndonje email i njejte me ate te cilin deshiron te regjistrohet useri
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
