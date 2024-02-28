import Foundation
import SQLite3
import CryptoKit

class LoginRepository {
    
    static func loginUser(db: OpaquePointer?, username: String, enteredPassword: String) -> Bool {
        let query = "SELECT password FROM users WHERE username = ?"
        var statement: OpaquePointer? = nil
        

        guard sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK else {
            print("Error preparing login statement")
            sqlite3_finalize(statement)
            return false
        }
        
        //Patjeter duhet te "finalize statement" perndryshe nuk mund te manipulojme me databaze pas login, shfaqe errorin qe eshte locked
        defer {
            sqlite3_finalize(statement)
        }
        
        guard sqlite3_bind_text(statement, 1, username, -1, nil) == SQLITE_OK else {
            print("Error finding username to login statement")
            return false
        }
        
        guard sqlite3_step(statement) == SQLITE_ROW else {
            print("No user found with the given username")
            return false
        }
        
        let passwordFromDB = String(cString: sqlite3_column_text(statement, 0))
        print("Hashed password from DB \(passwordFromDB)")
                
        
        if passwordFromDB == enteredPassword {
            return passwordFromDB == enteredPassword
        } else {
            return false
        }
    }
        



}

