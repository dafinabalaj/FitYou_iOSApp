import Foundation
import SQLite3
import CryptoKit

class LoginRepository {
    
    static func loginUser(db: OpaquePointer?, username: String, enteredPassword: String) -> Bool {
        let query = "SELECT password, salt FROM users WHERE username = ?"
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
        
        let hashedPasswordFromDB = String(cString: sqlite3_column_text(statement, 0))
        let saltFromDB = String(cString: sqlite3_column_text(statement, 1))
        
        if let hashedEnteredPassword = hashPassword(enteredPassword, salt: saltFromDB) {
            return hashedEnteredPassword == hashedPasswordFromDB
        } else {
            return false
        }
    }
        
    private static func hashPassword(_ password: String, salt: String) -> String? {
        let saltedPassword = password + salt

        if let passwordData = saltedPassword.data(using: .utf8) {
            let hashed = SHA256.hash(data: passwordData)
            return hashed.compactMap { String(format: "%02x", $0) }.joined()
        }
        return nil
    }

}

