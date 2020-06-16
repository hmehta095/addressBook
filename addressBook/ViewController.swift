//
//  ViewController.swift
//  addressBook
//
//  Created by Himanshu Mehta on 2020-06-16.
//  Copyright © 2020 Himanshu Mehta. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var savedLabel: UILabel!
    
    @IBOutlet weak var fNametextField: UITextField!
    
    @IBOutlet weak var lNametextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var PhoneTextField: UITextField!
    
 
    
    var books: [Book]?
            override func viewDidLoad() {
                
                super.viewDidLoad()
                // Do any additional setup after loading the view, typically from a nib.
                        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.saveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
                //        self.loadData()
                        self.loadCoreData()
                        
            }
            
            func getDataFilePath() -> String {
                let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
                let filePath = documentsPath.appending("testData.txt")
                return filePath
            }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        print("button pressed")
              let fname = fNametextField.text ?? ""
                      let lname = lNametextField.text ?? ""
                      let email = emailTextField.text ?? "@gmail.com"
                      let phone = Int(PhoneTextField.text ?? "647-609-6005") ?? 647-609-6005
                      
                      let book = Book(fname: fname, lname: lname, email: email, phone: phone)
              print("data saved")
        let alert = UIAlertController(title: "Add Address Book", message: "Contact saved successfully", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
       

        self.present(alert, animated: true)
                      self.books?.append(book)
             
    }

            func loadData() {
                self.books = [Book]()
                let filePath = self.getDataFilePath()
                
                if FileManager.default.fileExists(atPath: filePath) {
                    do {
                        // extract data
                        let fileContents = try String(contentsOfFile: filePath)
                        let contentArray = fileContents.components(separatedBy: "\n")
                        
                        for content in contentArray {
                            let bookContent = content.components(separatedBy: ",")
                            if bookContent.count == 4 {
                                let book = Book(fname: bookContent[0], lname: bookContent[1], email: bookContent[2], phone: Int(bookContent[3])!)
                                self.books?.append(book)
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
            }
            
            override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                let AddressBook = segue.destination as! AddressBook
                AddressBook.books = self.books
            }
            
            @objc func saveData() {
                let filePath = self.getDataFilePath()
                var saveString = ""
                
                for book in self.books! {
                    saveString = "\(saveString)\(book.fname),\(book.lname),\(book.email),\(book.phone)\n"
                }
                
                do {
                    try saveString.write(toFile: filePath, atomically: true, encoding: .utf8)
                } catch {
                    print(error)
                }
            }
            
            func loadCoreData() {
                books = [Book]()
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookModel")
                
                do {
                    let results = try managedContext.fetch(fetchRequest)
                    if results is [NSManagedObject] {
                        for result in (results as! [NSManagedObject]) {
                            let fname = result.value(forKey: "fname") as! String
                            let lname = result.value(forKey: "lname") as! String
                            let email = result.value(forKey: "email") as! String
                            let phone = result.value(forKey: "phone") as! Int
                            
                            books?.append(Book(fname: fname, lname: lname, email: email, phone: phone))
                        }
                    }
                } catch {
                    print(error)
                }
                
            }
            @objc func saveCoreData() {
                clearCoreData()
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let bookEntityDescription = NSEntityDescription.entity(forEntityName: "BookModel", in: managedContext)!
                for book in books! {
                    let bookEntity = NSManagedObject(entity: bookEntityDescription, insertInto: managedContext)
                    bookEntity.setValue(book.fname, forKey: "fname")
                    bookEntity.setValue(book.lname, forKey: "lname")
                    bookEntity.setValue(book.email, forKey: "email")
                    bookEntity.setValue(book.phone, forKey: "phone")
                }
                
                do {
                    try managedContext.save()
                } catch {
                    print(error)
                }
                
                fNametextField.text = ""
                lNametextField.text = ""
                emailTextField.text = ""
                PhoneTextField.text = ""
                
            }
            
            func clearCoreData() {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let managedContext = appDelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookModel")
                
                fetchRequest.returnsObjectsAsFaults = false
                
                do {
                    let results = try managedContext.fetch(fetchRequest)
                    
                    for managedObject in results {
                        if let managedObjectData = managedObject as? NSManagedObject {
                            managedContext.delete(managedObjectData)
                        }
                    }
                } catch {
                    print(error)
                }
            }
            


        }

