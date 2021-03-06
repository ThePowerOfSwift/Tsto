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


class NewGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
   var groupName = ""
   let cModel = DataModel.shared
   var mensallo = TextComposer()
   var contacts = [CNContact]()
   var selectedSrings = [String]()
   
   @IBOutlet weak var selectedCountLabel: UILabel!
   @IBOutlet weak var newGroupNameTextfield: UITextField!
   @IBOutlet weak var GroupNameLabel: UILabel!
   @IBOutlet weak var newGroupTableView: UITableView!
   
   
   
   @IBAction func saveButton(_ sender: UIButton) {
      groupName = newGroupNameTextfield.text!
      let contactsIds = getArrayofContactsID()
      cModel.creatGroupAndAddContacts(contactIdentifiers: contactsIds, groupName: groupName)
      dismiss(animated: true, completion: nil)
   }// END Button
   

   //MARK: tableView func
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contacts.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let  cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath) as? NewGroupTableViewCell
      //Name
      let fullname = "\(contacts[indexPath.row].givenName)  \(contacts[indexPath.row].familyName)"
      cell?.fullName.text  =  fullname //contacts[indexPath.row].givenName //fullname
      //Phopne
      for phoneNumber in contacts[indexPath.row].phoneNumbers {
         if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
            let phoneNumberString = phoneNumberStruct.stringValue
            cell?.phone.text = phoneNumberString
         }
      }
      //email
      for email in contacts[indexPath.row].emailAddresses {
         cell?.email.text = email.value as String
      }
      //photo
      if contacts[indexPath.row].imageDataAvailable {
         let image = UIImage(data: contacts[indexPath.row].imageData!)
         cell?.photo.image = image
         cell?.photo.layer.cornerRadius = (cell?.photo.frame.size.width)! / 2;
         cell?.photo.clipsToBounds = true
      }
      return cell!
   }//end of == tableView func
   
   //MARK: Select multiple rows and  put a check mark in the row
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if let cell = tableView.cellForRow(at: indexPath) {
         if cell.isSelected {
            cell.accessoryType = .checkmark
         }
      }
      if let sr = tableView.indexPathsForSelectedRows {
         selectedCountLabel.text = String (sr.count)
         print("\n\n ####  CELL # SELECTED CONTACT AT INDEXPATH :\(sr)")
         print("\n\n  SELECTED CONTACT NAME  :\(contacts[indexPath.row].givenName )")
         print("\n\n  SELECTED CONTACT IDENTIFIRE  :\(contacts[indexPath.row].identifier )")
      }
   }
   
   //MARK: UnSelect multiple rows and  take out the  check mark in the row
   func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
      if let cell = tableView.cellForRow(at: indexPath as IndexPath) {
         cell.accessoryType = .none
      }
      if let sr = tableView.indexPathsForSelectedRows {
        selectedCountLabel.text = sr.count as? String
      }
   }
   
   
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
      textField.resignFirstResponder()
      return true
   }
   
   //MARK: ViewDidLad ---------------------------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      
      autorization()
      contacts = cModel.fetchContacts()
      newGroupTableView.reloadData()
      self.newGroupNameTextfield.delegate = self;
   }//@
   
  
   
   func textFieldReturn(_ textField: UITextField) -> Bool {
      self.view.endEditing(true)
      return false
   }
   
   //MARK: Alert
   func alert(message: String) {
      let alertController = UIAlertController(title: "\(message.capitalized) is a required field" , message: "Please enter your \(message)", preferredStyle: .alert)
      let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      alertController.addAction(defaultAction)
      self.present(alertController, animated: true, completion: nil)
      
   }
   
   
   func autorization () {
      
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         newGroupTableView.reloadData()
      } else if status == .denied {
         let alertController = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)
      }
      
   }
   
   func getArrayofContactsID () -> [String] {
      
      if let indexPaths = newGroupTableView.indexPathsForSelectedRows {
         for indexPath in indexPaths {
            let contactID = contacts[indexPath.row].identifier
            selectedSrings.append(contactID)
         }
      } else {
         let alertController = UIAlertController(title: "Oops!", message: "there is no contacts selected ", preferredStyle: UIAlertControllerStyle.alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)
      }
      return selectedSrings
   }
   
   
   
   
   
   
   
   
   
}// END of ContacsViewController
