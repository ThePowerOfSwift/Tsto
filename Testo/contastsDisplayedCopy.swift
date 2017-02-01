////
////  NewGroupViewController.swift
////  Testo
////
////  Created by oskar morett on 1/31/17.
////  Copyright © 2017 oskar morett. All rights reserved.
////
//
//import UIKit
//import Contacts
//import ContactsUI
//
//
//class NewGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//   
//   
//   
//   
//   @IBAction func selecting(_ sender: UIBarButtonItem) {
//      
//      newGroupTableView.setEditing(true, animated: true)
//      editButtonPressed()
//   }
//   
//   
//   @IBOutlet weak var newGroupTableView: UITableView!
//   
//   
//   var mensallo = TextComposer()
//   var contacts = [CNContact]()
//   
//   
//   //MARK: tableView func
//   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//      return contacts.count
//   }
//   
//   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//      let  cell = tableView.dequeueReusableCell(withIdentifier: "NewGroupCell", for: indexPath) as? NewGroupTableViewCell
//      
//      cell?.fullName.text  = contacts[indexPath.row].givenName
//      
//      for phoneNumber in contacts[indexPath.row].phoneNumbers {
//         if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
//            let phoneNumberString = phoneNumberStruct.stringValue
//            cell?.phone.text = phoneNumberString
//         }
//      }//end phoneNumber
//      
//      for email in contacts[indexPath.row].emailAddresses {
//         
//         cell?.email.text = email.value as String
//      }//end of email
//      
//      
//      //>>>>>>>>>>>>>>>>>>>
//      if contacts[indexPath.row].imageDataAvailable {
//         
//         let image = UIImage(data: contacts[indexPath.row].imageData!)
//         cell?.photo.image = image
//         
//      }
//      
//      return cell!
//      
//   }//end of == tableView func
//   
//   
//   // MARK: Create a MessageComposer
//   let textComposer = TextComposer()
//   
//   
//   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//      
//      // Make sure the device can send text messages
//      if (textComposer.canSendText()) {
//         
//         for phoneNumber in contacts[indexPath.row].phoneNumbers {
//            if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
//               let phoneNumberString = phoneNumberStruct.stringValue
//               mensallo.textMessageRecipients.append(phoneNumberString)
//               print (mensallo.textMessageRecipients)
//               
//            }
//         }
//         if mensallo.textMessageRecipients.count > 0 {
//            // Obtain a configured MFMessageComposeViewController
//            let messageComposeVC = mensallo.configuredMessageComposeViewController()
//            // Present the configured MFMessageComposeViewController instance
//            present(messageComposeVC, animated: true, completion: nil)
//         }
//         
//      } else {
//         // Let the user know if his/her device isn't able to send text messages
//         let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
//         errorAlert.show()
//      }
//   }
//   
//   
//   //MARK: NewGroupViewController
//   
//   override func viewDidLoad() {
//      super.viewDidLoad()
//      let titlelabel = "New Group"
//      title =  titlelabel
//      contacts = Info.shared.fetchContacts()
//      newGroupTableView.reloadData()
//      
//      navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewGroupViewController.editButtonPressed))
//      
//   }
//   
//   override func didReceiveMemoryWarning() {
//      super.didReceiveMemoryWarning()
//      
//   }
//   
//   func editButtonPressed(){
//      newGroupTableView.setEditing(!newGroupTableView.isEditing, animated: true)
//      if newGroupTableView.isEditing == true{
//         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewGroupViewController.editButtonPressed))
//      }else{
//         navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(NewGroupViewController.editButtonPressed))
//      }
//   }
//   
//   
//   
//   
//   
//   
//   
//   
//   
//   
//}// END of ContacsViewController
