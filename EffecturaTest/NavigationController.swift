//
//  NavigationController.swift
//  EffecturaTest
//
//  Created by Roman on 12.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let initialViewController = self.topViewController as? UsersTableViewController else {
            return
        }
        let assembler = UsersModuleAssembler()
        assembler.assemble(initialViewController)
    }
}
