//
//  UserCell.swift
//  EffecturaTest
//
//  Created by Roman on 13.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

final class UserCell: UITableViewCell {
    @IBOutlet private(set) var nameLabel: UILabel?
    @IBOutlet private(set) var birthdayLabel: UILabel?
    @IBOutlet private(set) var genderLabel: UILabel?
    
    func setup(name: String, birthday: Date, gender: Gender) {
        nameLabel?.text = name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        birthdayLabel?.text = dateFormatter.string(from: birthday)
        
        genderLabel?.text = gender.description
    }
}
