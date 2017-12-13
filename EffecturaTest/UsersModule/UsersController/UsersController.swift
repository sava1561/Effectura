//
//  UsersController.swift
//  EffecturaTest
//
//  Created by Roman on 11.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import Foundation

final class UsersController {
    var model: UsersModelInput?
    var view: UsersViewInput?
}

extension UsersController: UsersControllerViewInput {
    func didLoad() {
        model?.loadUsers()
    }
}

extension UsersController: UsersControllerModelInput {
    func updateUsers(_ users: [UserData]) {
        view?.updateUsers(users)
    }
}
