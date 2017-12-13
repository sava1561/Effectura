//
//  UserCreateViewController.swift
//  EffecturaTest
//
//  Created by Roman on 12.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit
import TextFieldEffects
import FirebaseDatabase

final class UserCreateViewController: UIViewController {
    let onSaveSegueIdentifier: String = "SaveUser"
    private var datePicker: UIDatePicker?
    private var genderPicker: GenderPicker?
    
    @IBOutlet private(set) var nameTextfield: HoshiTextField?
    @IBOutlet private(set) var birthdayTextfield: HoshiTextField?
    @IBOutlet private(set) var genderTextfield: HoshiTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        setupGenderPicker()
        setupNavigationBar()
        birthdayTextfield?.inputView = datePicker
        genderTextfield?.inputView = genderPicker
    }
    
    private func setupDatePicker() {
        datePicker = UIDatePicker()
        datePicker?.date = Date()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(didSelectDate), for: UIControlEvents.valueChanged)
    }
    
    private func setupGenderPicker() {
        genderPicker = GenderPicker()
        genderPicker?.delegate = genderPicker
        genderPicker?.dataSource = genderPicker
        genderPicker?.genderDelegate = self
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc private func didSelectDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        guard let date = datePicker?.date else {
            assertionFailure()
            return
        }
        birthdayTextfield?.text = "\(dateFormatter.string(from: date))"
    }
    
    @objc private func save() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        guard let date = dateFormatter.date(from: (birthdayTextfield?.text)!) else {
            showAlert(with: "Wrong birthday")
            return
        }
        
        guard let gender = genderTitles[(genderTextfield?.text)!] else {
            showAlert(with: "Wrong Gender")
            return
        }
        
        guard let name = nameTextfield?.text else {
            showAlert(with: "Wrong name")
            return
        }
        
        if name.isEmpty {
            showAlert(with: "Wrong name")
            return
        }
        let user = User(name: (nameTextfield?.text)!, birthday: date, gender: gender)
        let ref = Database.database().reference()
        ref.child("users").child(user.getName()).setValue(user.toJSONString())
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func showAlert(with message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "OK",
                style: .cancel,
                handler: {
                    _ in
                    alertController.removeFromParentViewController()
                }
            )
        )
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UserCreateViewController: GenderPickerDelegate {
    func didSelectGender(_ genderPicker: GenderPicker, gender: Gender) {
        genderTextfield?.text = gender.description
    }
}
