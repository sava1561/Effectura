//
//  UsersTableViewController.swift
//  EffecturaTest
//
//  Created by Roman on 11.12.2017.
//  Copyright © 2017 Roman. All rights reserved.
//

import UIKit

final class UsersTableViewController: UITableViewController {
    var controller: UsersControllerViewInput?
    var usersData: [UserData] = []
    
    let reuseCellId: String = "UserCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller?.didLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controller?.didLoad()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCellId, for: indexPath) as? UserCell else {
            return UITableViewCell()
        }
        cell.setup(
            name: usersData[indexPath.item].name,
            birthday: usersData[indexPath.item].birthday,
            gender: usersData[indexPath.item].gender
        )
        return cell
    }
    
    @IBAction func filterButtonDidTap(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(
            title: "Filter",
            message: nil,
            preferredStyle: .actionSheet
        )
        let byNameAction = UIAlertAction(
            title: "Name",
            style: .default,
            handler:
            {
                _ in
                self.usersData.sort(by: {
                    (user1, user2) in
                    return user1.name > user2.name
                })
                self.tableView.reloadData()
            }
        )
        
        let byBirthdayAction = UIAlertAction(
            title: "Birthday",
            style: .default,
            handler:
            {
                _ in
                self.usersData.sort(by: {
                    (user1, user2) in
                    return user1.birthday > user2.birthday
                })
                self.tableView.reloadData()
            }
        )
        
        alert.addAction(byNameAction)
        alert.addAction(byBirthdayAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension UsersTableViewController: UsersViewInput {
    func updateUsers(_ users: [UserData]) {
        self.usersData = users
        self.tableView.reloadData()
    }
}
