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
   var contactsLookup = [[CNContact]]()
   var groups = [CNGroup]()
   var groupNames = [String] ()
   weak var delageta : CellDelegate?
   
   @IBOutlet weak var mpTableView: UITableView!
   
   
   @IBAction func crollToSection(_ sender: UIButton) {
     
      
   }
   
   
   
   
   
   //MARK: TableView ----------------------------------------------------------------------------------
   func scrollToFirstRow(section: Int) {
      let indexPath = IndexPath(row: 0, section: 8)
      self.mpTableView.scrollToRow(at: indexPath as IndexPath, at: .top, animated: true)  //(indexPath, atScrollPosition: .Top, animated: true)
      
   
      
      
   }
   
   func numberOfSections(in tableView: UITableView) -> Int {
      return groupNames.count
   }
   
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      
      return groupNames[section]
   }

   //Row
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contactsLookup[section].count
   }//@
   
   //Cell at Row
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "mpTableViewCell", for: indexPath) as? MPTableViewCell
      // name
      
      let groupX = contactsLookup[indexPath.section]
      let fullname = "\(groupX[indexPath.row].givenName)  \(groupX[indexPath.row].familyName)"
          cell?.fullName.text  =  fullname //contacts[indexPath.row].givenName //fullname
      //Phone
      for phoneNumber in groupX[indexPath.row].phoneNumbers {
         if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
            let phoneNumberString = phoneNumberStruct.stringValue
            cell?.phone.text = phoneNumberString
         }
      }
      //Email
      for email in groupX[indexPath.row].emailAddresses {
         cell?.email.text = email.value as String
      }
      // Photo
      if groupX[indexPath.row].imageDataAvailable {
         let image = UIImage(data: groupX[indexPath.row].imageData!)
         cell?.photo.image = image
      }
      return cell!
   }//@
   
   
   
   //SEND TEXT
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      if (mensallo.canSendText()) { // Make sure the device can send text messages
         let groupX = contactsLookup[indexPath.section]
         for phoneNumber in groupX[indexPath.row].phoneNumbers {
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
      func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
         let call = UITableViewRowAction(style: .default, title: "CAll") { (action, indexPath) in
            
            
            let groupX = self.contactsLookup[indexPath.section]
            for phoneNumber in groupX[indexPath.row].phoneNumbers {
               if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
                  let phoneNumberString = phoneNumberStruct.stringValue
                  let numericSet = "0123456789"
                  let filteredCharacters = phoneNumberString.characters.filter {
                     return numericSet.contains(String($0))
                  }
                  let filteredString = String(filteredCharacters)
                   print(groupX[indexPath.row].givenName)
                  print(filteredString)
            guard let number = URL(string: "telprompt://" + filteredString ) else { return }
            UIApplication.shared.open(number, options: [:], completionHandler: nil)
               }
            }
         }
         call.backgroundColor = UIColor.green
      return [call]
      }//@
   
   
   //@ TableView  Funcs -------------------------------------------------------------------------------------------------------
   
   
   //MARK: viewDidLoad --------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      
      autorization()
//      mpTableView.delegate = self
//    mpTableView.dataSource = self
   contactsLookup = cModel.getContactsByGroup()
      print (contactsLookup)
   groupNames  = cModel.getGroupsNames()
    contactsLookup = cModel.getContactsByGroup()
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

extension MPTableViewController : CellDelegate{
   

   internal func didSelectedSection(section: Int) {
      
      mpTableView.scrollToRow(at: IndexPath(row: 0, section: section ), at: .top, animated: true)         
   }

   
}
