//
//  User.swift
//  EffecturaTest
//
//  Created by Roman on 11.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import Foundation
import FirebaseDatabase

enum Gender {
    case male
    case female
    
    var description: String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        }
    }
}

let genderTitles: [String: Gender] =
    [
        Gender.male.description: .male,
        Gender.female.description: .female
]

struct UserData {
    let name: String
    let birthday: Date
    let gender: Gender
}

final class User {
    private var name: String
    private var birthday: Date
    private var gender: Gender
    
    init(name: String, birthday: Date, gender: Gender) {
        self.name = name
        self.birthday = birthday
        self.gender = gender
    }
    
    convenience init(dataSnapshot: DataSnapshot) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        
        guard
            let snaphotValue = dataSnapshot.value as? [String: Any],
            let birthdayString = snaphotValue["birthday"] as? String,
            let genderString = snaphotValue["gender"] as? String
        else {
            self.init(name: "Empty", birthday: Date(), gender: .male)
            return
        }

        self.init(
            name: dataSnapshot.key,
            birthday: dateFormatter.date(from: birthdayString) ?? Date(),
            gender: genderTitles[genderString] ?? .male)
    }
    
    func getName() -> String {
        return name
    }
    
    func getBirthday() -> Date {
        return birthday
    }
    
    func getGender() -> Gender {
        return gender
    }
    
    func toJSONString() -> [String: Any] {
        let calendar = Calendar.autoupdatingCurrent
        let day = calendar.component(.day, from: birthday)
        let month = calendar.component(.month, from: birthday)
        let year = calendar.component(.year, from: birthday)
        let dateString = "\(day)-\(month)-\(year)"
        
        return
        [
            "birthday": dateString,
            "gender": gender.description
        ]
    }
}
