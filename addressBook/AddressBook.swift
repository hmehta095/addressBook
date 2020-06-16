//
//  AddressBook.swift
//  addressBook
//
//  Created by Himanshu Mehta on 2020-06-16.
//  Copyright © 2020 Himanshu Mehta. All rights reserved.
//

import UIKit
import MessageUI


class AddressBook: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchview: UISearchBar!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
     var filterdata:[String]!
    
    var books: [Book]?
    var name: [String] = ["him"]
       override func viewDidLoad() {
           super.viewDidLoad()
//        filterdata = booksname
        self.addDoneButtonOnKeyboard()
        

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
    
   
    @IBAction func shareButtonPressed(_ sender: Any) {
        print("button preseed3")
        
        self.sendEmail()
         
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
         mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
            mail.setToRecipients(["hmehta095@gmail.com"])
         mail.setMessageBody("\(String(describing: books))", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
         let alert = UIAlertController(title: "Add Address Book", message: "Error in opening gmail.", preferredStyle: .alert)

          alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
         

          self.present(alert, animated: true)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let book = self.books![indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
           
           cell.textLabel?.text = book.fname
        
        cell.detailTextLabel?.text = String(book.phone)
        self.name.append(book.fname)
           // Configure the cell...

           return cell
        
        
        
       
       
       }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
         
                          // filterdata  = searchText.isEmpty ? data : data.filter {(item : String) -> Bool in

                          filterdata = searchText.isEmpty ? name : name.filter { $0.contains(searchText) }

                          //return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil

                      tableView.reloadData()
                      
                  }
    
    func addDoneButtonOnKeyboard(){
             let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
             doneToolbar.barStyle = .default

             let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
             let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

             let items = [flexSpace, done]
             doneToolbar.items = items
             doneToolbar.sizeToFit()

         }

         @objc func doneButtonAction(){
             searchview.resignFirstResponder()
         }
       
}
