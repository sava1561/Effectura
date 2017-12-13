//
//  GenderPicker.swift
//  EffecturaTest
//
//  Created by Roman on 12.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

protocol GenderPickerDelegate: class {
    func didSelectGender(_ genderPicker: GenderPicker, gender: Gender)
}

final class GenderPicker: UIPickerView {
    weak var genderDelegate: GenderPickerDelegate?

    let genders: [Gender] =
    [
        .male,
        .female
    ]
}

extension GenderPicker: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderDelegate?.didSelectGender(self, gender: genders[row])
    }
}

extension GenderPicker: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
}
