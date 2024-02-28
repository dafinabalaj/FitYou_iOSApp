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
    
     static func generateSalt() -> String {
          let saltLength = 16
          let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
          let allowedCharsCount = UInt32(allowedChars.count)
          var randomString = ""
          for _ in 0..<saltLength {
              let randomNum = Int(arc4random_uniform(allowedCharsCount))
              let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
              randomString += String(allowedChars[randomIndex])
          }
          return randomString
      }
      
//      static func hashPassword(_ password: String, salt: String) -> String? {
//          let passwordWithSalt = password + salt
//
//          if let passwordData = passwordWithSalt.data(using: .utf8) {
//              let hashed = SHA256.hash(data: passwordData)
//              return hashed.compactMap { String(format: "%02x", $0) }.joined()
//          }
//          return nil
//      }
    
     static func hashPassword(_ password: String, salt: String) -> String? {
        let passwordWithSalt = password + salt
        if let passwordData = passwordWithSalt.data(using: .utf8) {
            let hashed = SHA256.hash(data: passwordData)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }
        return nil
    }


      
//    static func insertUser(db: OpaquePointer?, username: String, password: String, email: String) {
//
//             guard let db = db else {
//                 print("Database pointer is nil")
//                 return
//             }
//
//             let salt = generateSalt()
//             guard let hashedPassword = hashPassword(password, salt: salt) else {
//                 print("Error hashing password")
//                 return
//             }
//
//             let insertSQL = "INSERT INTO users (username, password, email, salt) VALUES (?, ?, ?, ?)"
//             var statement: OpaquePointer? = nil
//
//             if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
//                print(username)
//                print(email)
//                print(password)
//                 sqlite3_bind_text(statement, 1, username, -1, nil)
//                 sqlite3_bind_text(statement, 2, hashedPassword, -1, nil)
//                 sqlite3_bind_text(statement, 3, email, -1, nil)
//                 sqlite3_bind_text(statement, 4, salt, -1, nil)
//
//                 if sqlite3_step(statement) == SQLITE_DONE {
//                     print("Successfully inserted user")
//                 } else {
//                     print("Error inserting user")
//                 }
//             } else {
//                 print("Error preparing insert statement")
//             }
//
//             sqlite3_finalize(statement)
//         }

    static func insertUser(db: OpaquePointer?, username: String, password: String, email: String) {
        guard let db = db else {
            print("Database pointer is nil")
            return
        }

        let salt = generateSalt()
        guard let hashedPassword = hashPassword(password, salt: salt) else {
            print("Error hashing password")
            return
        }

        let insertSQL = "INSERT INTO users (username, password, email, salt) VALUES (?, ?, ?, ?)"
        var statement: OpaquePointer? = nil

        if sqlite3_prepare_v2(db, insertSQL, -1, &statement, nil) == SQLITE_OK {
            let cStringUsername = username.cString(using: .utf8)
            let cStringPassword = hashedPassword.cString(using: .utf8)
            let cStringEmail = email.cString(using: .utf8)
            let cStringSalt = salt.cString(using: .utf8)
            
            sqlite3_bind_text(statement, 1, cStringUsername, -1, nil)
            sqlite3_bind_text(statement, 2, cStringPassword, -1, nil)
            sqlite3_bind_text(statement, 3, cStringEmail, -1, nil)
            sqlite3_bind_text(statement, 4, cStringSalt, -1, nil)

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
