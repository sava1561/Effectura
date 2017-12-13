//
//  UsersControllerInput.swift
//  EffecturaTest
//
//  Created by Roman on 11.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import Foundation

protocol UsersControllerViewInput: class {
    func didLoad()
}

protocol UsersControllerModelInput: class {
    func updateUsers(_ users: [UserData])
}
