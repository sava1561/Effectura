//
//  UsersModel.swift
//  EffecturaTest
//
//  Created by Roman on 11.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class UsersModel {
    var controller: UsersControllerModelInput?
    private var databaseReference: DatabaseReference?
    private var users: [User] = []
    
    init() {
        databaseReference = Database.database().reference()
        startListening()
    }
    
    private func startListening() {
        databaseReference?.observe(.value, with:
        {
            (dataSnapshot) in
            self.loadUsers()
        })
    }
}

extension UsersModel: UsersModelInput {
    func loadUsers() {
        databaseReference?.child("users").observeSingleEvent(of: .value, with: {
            (snapshot) in
            var usersData: [UserData] = []
            self.users.removeAll()
            for item in snapshot.children {
                guard let shot = item as? DataSnapshot else {
                    return
                }
                let user = User(dataSnapshot: shot)
                self.users.append(user)
                usersData.append(
                    UserData(
                        name: user.getName(),
                        birthday: user.getBirthday(),
                        gender: user.getGender()
                    )
                )
            }
            self.controller?.updateUsers(usersData)
        })
    }
}
