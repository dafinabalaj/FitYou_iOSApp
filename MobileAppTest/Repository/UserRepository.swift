//
//  UserRepository.swift
//  MobileAppTest
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import Foundation
import SQLite3

var user: UserModel?

class UserRepository {
    
    
    static func fetchUserByUsername(db: OpaquePointer?, username: String) {
        let query = "SELECT id, username, email FROM users WHERE username = ?"
        var statement: OpaquePointer? = nil
        
        guard sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK else {
            print("Error preparing fetch user statement")
            return
        }
        
        defer {
            sqlite3_finalize(statement)
        }
        
        guard sqlite3_bind_text(statement, 1, username, -1, nil) == SQLITE_OK else {
            print("Error binding username to fetch user statement")
            return
        }
        
        guard sqlite3_step(statement) == SQLITE_ROW else {
            print("No user found with the given username")
            return
        }
        
        let id = Int(sqlite3_column_int(statement, 0))
        let username = String(cString: sqlite3_column_text(statement, 1))
        let email = String(cString: sqlite3_column_text(statement, 2))
        
        user = UserModel(id: id, username: username, email: email)
    }
}

