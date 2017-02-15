//
//  addContactViewController.swift
//  Testo
//
//  Created by oskar morett on 2/11/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit

import Contacts
import ContactsUI

class AddContactViewController: UIViewController,UITableViewDelegate, UITableViewDataSource
{
   
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var efect: UIImageView!
   
   let cModel = DataModel.shared
   var mensallo = TextComposer()
   var contactsLookup = [[CNContact]]()
   var groups = [CNGroup]()
   var contactID = String()
   var contactSelecteted = CNContact()
   
   @IBAction func outAreaTouched(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return groups.count
      
   }//@
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "addContactsCell", for: indexPath) as? AddContactTableViewCell
           cell?.name.text = groups[indexPath.row].name
         return cell!
   }//@
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       print("\n\n\n  3 ------####### GROUP CELL PRESED ######################******")
      print("\n\n\n ***** GROUP SELECTED ******")
      print("GroupNAME: \(groups[indexPath.row].name)")
      print("GroupInfo: \(groups[indexPath.row].identifier)")
      print("\n\n\n *****  CELL PRINT CONTACT TO BE ADDED ******")
      print("Contact Identifier: \(contactSelecteted.identifier)")
      print("Contact NAME: \(contactSelecteted.givenName)")
      cModel.addONEContactToGroup(contactIdentifier: contactSelecteted.identifier, groupID:  groups[indexPath.row].identifier )
      dismiss(animated: true, completion: nil)
   }


    override func viewDidLoad() {
        super.viewDidLoad()
      autorization()
      groups = getGRoups()
      efect.layer.cornerRadius = 8
      efect.layer.borderWidth = 1.5
      contactID = contactSelecteted.identifier
      print("\n\n\n^^^^^^^  VIEW DID LOAD RECIVE ---- CONTACT SELCTED  ^^^^^^^^^******")
      print("Contact ID: \(contactSelecteted.identifier)")
      print("Contact NAME: \(contactSelecteted.givenName)")
      tableView.reloadData()
      NotificationCenter.default.addObserver(self, selector: #selector(MPCollectionViewController.refreshContacts), name: NSNotification.Name(rawValue: "CNContactStoreDidChangeNotification"), object: nil)
      
   }//@
   
   func refreshContacts() {
      print("REFRESHING CONTACTS")
      DispatchQueue.main.async{
         self.tableView.reloadData()
      }
   }
   
   
   func getGRoups() -> [CNGroup] {
      let store = CNContactStore()
      var allGroups = [CNGroup]()
      do { allGroups = try store.groups(matching: nil)
           groups = allGroups
      } catch {
         print("Error fetching Groups")
      }
      return groups
   }//@

   
   
   

   func autorization () {
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         tableView.reloadData()
      } else if status == .denied {
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         present(alert, animated: true, completion: nil)
      }
      
   }
   
   

   
   
}//@
