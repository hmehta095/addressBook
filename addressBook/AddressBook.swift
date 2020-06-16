//
//  AddressBook.swift
//  addressBook
//
//  Created by Himanshu Mehta on 2020-06-16.
//  Copyright © 2020 Himanshu Mehta. All rights reserved.
//

import UIKit

class AddressBook: UITableViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var books: [Book]?
       override func viewDidLoad() {
           super.viewDidLoad()

           // Uncomment the following line to preserve selection between presentations
           // self.clearsSelectionOnViewWillAppear = false

           // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
           // self.navigationItem.rightBarButtonItem = self.editButtonItem
       }

       // MARK: - Table view data source

       override func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           // #warning Incomplete implementation, return the number of rows
           return self.books?.count ?? 0
       }

       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let book = self.books![indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
           
           cell.textLabel?.text = book.fname
        cell.detailTextLabel?.text = String(book.phone)

           // Configure the cell...

           return cell
       }
       
}
