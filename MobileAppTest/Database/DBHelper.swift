//
//  DBHelper.swift
//  MobileAppTest
//
//  Created by THIS on 26.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import Foundation
import SQLite3

class DBHelper {
    static func getDatabasePointer(databaseName: String) -> OpaquePointer? {
        
        var databasePointer: OpaquePointer?
        
        
        let documentDatabasePath = FileManager.default.urls(for: .documentDirectory, in:
            .userDomainMask)[0].appendingPathComponent(databaseName).path
        
        if FileManager.default.fileExists(atPath: documentDatabasePath){
            print("Database Exists (already)")
        }
        else {
            
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else{
                print("Unwrapping Error: Bundle Database Path doesn't exist")
                return nil
            }
            
            do{
                try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: documentDatabasePath)
                print("Database created (copied)")
            }catch{
                print("Error: \(error.localizedDescription)")
                return nil
            }
        }
        
        if sqlite3_open(documentDatabasePath, &databasePointer)==SQLITE_OK{
            print("Successfully open database")
            print("Database path: \(documentDatabasePath)")
        }
        else{
            print("Could not open database")
            
        }
        return databasePointer
    }
    
    static func closeDatabase(dbPointer: OpaquePointer?) {
        guard let db = dbPointer else {
            print("Database pointer is already nil")
            return
        }

        if sqlite3_close(db) == SQLITE_OK {
            print("Database closed successfully.")
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("Failed to close database. Error: \(errorMessage)")
        }
    }

    static func getDatabasePath(databaseName: String) -> String? {
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let databasePath = documentDirectory.appendingPathComponent(databaseName).path
                return databasePath
            }
            return nil
        }}
