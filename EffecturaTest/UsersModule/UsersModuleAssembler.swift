//
//  UsersModuleAssembler.swift
//  EffecturaTest
//
//  Created by Roman on 12.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import Foundation

final class UsersModuleAssembler {
    func assemble(_ view: UsersTableViewController) {
        let model = UsersModel()
        let controller = UsersController()
        
        controller.model = model
        model.controller = controller
        view.controller = controller
        controller.view = view
    }
}
