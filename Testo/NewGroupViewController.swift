//
//  NewGroupViewController.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class NewGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   var groupName = ""
   var cModel : ContactModel!
   
   
   
   @IBOutlet weak var newGroupNameTextfield: UITextField!
   
   
   @IBOutlet weak var GroupNameLabel: UILabel!
   
   
   
   @IBAction func saveButton(_ sender: UIButton) {
    
      groupName = newGroupNameTextfield.text!
      addCNGroup(groupName: groupName)
      
      
      
      
      
      
      
   }// END Button
   
   
   
   
   
   
   
   
   @IBOutlet weak var newGroupTableView: UITableView!
   
   
   var mensallo = TextComposer()
   var contacts = [CNContact]()
   
   
   
   
   
   
   //MARK: tableView func
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contacts.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let  cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath) as? NewGroupTableViewCell
      let fullname = "\(contacts[indexPath.row].givenName)  \(contacts[indexPath.row].familyName)"
      
      cell?.fullName.text  =  fullname //contacts[indexPath.row].givenName //fullname
      
      for phoneNumber in contacts[indexPath.row].phoneNumbers {
         if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
            let phoneNumberString = phoneNumberStruct.stringValue
            cell?.phone.text = phoneNumberString
         }
      }//end phoneNumber
      
      for email in contacts[indexPath.row].emailAddresses {
         
         cell?.email.text = email.value as String
      }//end of email
      
      
      //>>>>>>>>>>>>>>>>>>>
      if contacts[indexPath.row].imageDataAvailable {
         
         let image = UIImage(data: contacts[indexPath.row].imageData!)
         cell?.photo.image = image
         
      }
      
      return cell!
      
   }//end of == tableView func
   
   
   
   
   
   // MARK: Create a MessageComposer
   let textComposer = TextComposer()
   
   
   
   
   //MARK: Select multiple rows and  put a check mark in the row
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      print("selected  \(contacts[indexPath.row])")
      
      if let cell = tableView.cellForRow(at: indexPath) {
         if cell.isSelected {
            cell.accessoryType = .checkmark
         }
      }
      
      if let sr = tableView.indexPathsForSelectedRows {
         print("didDeselectRowAtIndexPath selected rows:\(sr)")
      }
   }
   
   
   
   
   
   //////
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      
      print("deselected  \(contacts[indexPath.row])")
      
      if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
         cell.accessoryType = .none
      }
      
      if let sr = tableView.indexPathsForSelectedRows {
         print("didDeselectRowAtIndexPath selected rows:\(sr)")
      }
   }
   
   
   
   ///////
   
   
   
   //MARK: swipit to add to grpoup funcionality
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .insert {
      // Full name:
         var fullname = "\(contacts[indexPath.row].givenName)  \(contacts[indexPath.row].familyName)"
         
      // Get Primary phone
         var primarynumber = String()
         for phoneNumber in contacts[indexPath.row].phoneNumbers {
            if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
               primarynumber = phoneNumberStruct.stringValue
               
            }
         }//end phoneNumber
         
      // email
         var email = String()
         for emailx in contacts[indexPath.row].emailAddresses {
            email = emailx.value as String
         }//end of email
         
         
         // save  on FB
         //         cModel.createContact(name: fullname,
         //                              company: contacts[indexPath.row].organizationName,
         //                              phone: primarynumber,
         //                              email: email,
         //                              extra: "0",
         //                              notes: "0")
      }
   }
   
   
   //MARK: NewGroupViewController
   
   override func viewDidLoad() {
      super.viewDidLoad()
      let titlelabel = "New Group"
      title =  titlelabel
      contacts = Info.shared.fetchContacts()
      newGroupTableView.reloadData()
      
      
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      
   }
   
   
   func addCNGroup (groupName: String) {
      let contactsStore = CNContactStore()
      var newGroup = CNMutableGroup()
      var saveReq = CNSaveRequest()
      newGroup.name = groupName
      saveReq.add(newGroup, toContainerWithIdentifier: nil)
      let error = NSError(domain: "testo creating contact error", code: 9999, userInfo: nil)
      do { try contactsStore.execute(saveReq)
         print ("saved")}
      catch { print("error") }
      
      
   }

   
   
   
   
   
   
   
   
}// END of ContacsViewController
