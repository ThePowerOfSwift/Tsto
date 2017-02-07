//
//  MPTableViewController.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class MPTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   let cModel = DataModel.shared
   var mensallo = TextComposer()
   var contactsInGroups = [CNContact]()
   var groups = [CNGroup]()
   
   
   @IBOutlet weak var mpTableView: UITableView!
   
   
   //MARK: TableView ----------------------------------------------------------------------------------
   
   //Row
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contactsInGroups.count
   }//@
   
   //Cell at Row
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "mpTableViewCell", for: indexPath) as? MPTableViewCell
      // name
      let fullname = "\(contactsInGroups[indexPath.row].givenName)  \(contactsInGroups[indexPath.row].familyName)"
          cell?.fullName.text  =  fullname //contacts[indexPath.row].givenName //fullname
      //Phone
      for phoneNumber in contactsInGroups[indexPath.row].phoneNumbers {
         if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
            let phoneNumberString = phoneNumberStruct.stringValue
            cell?.phone.text = phoneNumberString
         }
      }
      //Email
      for email in contactsInGroups[indexPath.row].emailAddresses {
         cell?.email.text = email.value as String
      }
      // Photo
      if contactsInGroups[indexPath.row].imageDataAvailable {
         let image = UIImage(data: contactsInGroups[indexPath.row].imageData!)
         cell?.photo.image = image
      }
      return cell!
   }//@
   
   
   
   //SEND TEXT
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if (mensallo.canSendText()) { // Make sure the device can send text messages
         for phoneNumber in contactsInGroups[indexPath.row].phoneNumbers {
            if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
               let phoneNumberString = phoneNumberStruct.stringValue
               mensallo.textMessageRecipients.append(phoneNumberString)
               print (mensallo.textMessageRecipients)
            }
         }
         if mensallo.textMessageRecipients.count > 0 {
         let messageComposeVC = mensallo.configuredMessageComposeViewController()// Obtain a configured MFMessageComposeViewController
            present(messageComposeVC, animated: true, completion: nil)// Present the configured MFMessageComposeViewController instance
         }
         
      } else {// Let the user know if his/her device isn't able to send text messages
         let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
         errorAlert.show()
      }
   }//@
   
   // MARK: swipt  to add to Call funcionality
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
         
         
      }
      
      
   }
   
   func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
      return "CAll" //or customize for each indexPath
   }
   
   //@-------------------------------------------------------------------------------------------------------
   
   
   //MARK: viewDidLoad --------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      
      autorization()
//      mpTableView.delegate = self
//      mpTableView.dataSource = self
      contactsInGroups = cModel.searchForContactsInGroup()
      mpTableView.reloadData()
      
   }
   
   
   //MARK: autorization
   func autorization () {
      
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         mpTableView.reloadData()
         
      } else if status == .denied {
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         present(alert, animated: true, completion: nil)
      }
      
   }
   
   
   
   
   
}//END MPtableViewController
