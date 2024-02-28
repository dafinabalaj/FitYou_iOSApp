//
//  UserModel.swift
//  MobileAppTest
//
//  Created by THIS on 28.2.24.
//  Copyright © 2024 THIS. All rights reserved.
//

import Foundation


class UserModel{
    
    let id: Int
    let username: String
    let email: String
    
    init(id: Int, username: String, email: String){
        self.id = id
        self.username = username
        self.email = email
    }
}

