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
//   ///////////////////////////////

//      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//   Make sure the device can send text messages
//         if (textComposer.canSendText()) {
//
//            for phoneNumber in contacts[indexPath.row].phoneNumbers {
//               if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
//                  let phoneNumberString = phoneNumberStruct.stringValue
//                  mensallo.textMessageRecipients.append(phoneNumberString)
//                  print (mensallo.textMessageRecipients)
//
//               }
//            }
//            if mensallo.textMessageRecipients.count > 0 {
//               // Obtain a configured MFMessageComposeViewController
//               let messageComposeVC = mensallo.configuredMessageComposeViewController()
//               // Present the configured MFMessageComposeViewController instance
//               present(messageComposeVC, animated: true, completion: nil)
//            }
//
//         } else {
//            // Let the user know if his/her device isn't able to send text messages
//            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
//            errorAlert.show()
//         }
//      }/// didSelectRowAt





////////////////
//   //PRODUCT CLASS:


//class Contact {
//   
//   var contactID: String?
//   var name: String
//   var company: String
//   var phone: String
//   var email: String
//   var contactPhoto: String
//   var extra: String
//   var notes: String
//   
//   var ref: FIRDatabaseReference?
//   
//   init(name: String, company: String, phone: String, email: String, contactPhoto: String, extra: String, notes: String) {
//      self.name = name
//      self.company = company
//      self.phone = phone
//      self.email = email
//      self.contactPhoto = contactPhoto
//      self.extra = extra
//      self.notes = notes
//      
//   }
//   
//   init(snapshot: FIRDataSnapshot) {
//      contactID = snapshot.key
//      let snapshotValue = snapshot.value as! [String : AnyObject]
//      name = snapshotValue["name"] as! String
//      company = snapshotValue["company"] as! String
//      phone = snapshotValue["phone"] as! String
//      email = snapshotValue["email"] as! String
//      contactPhoto = snapshotValue["contactPhoto"] as! String
//      extra = snapshotValue["extra"] as! String
//      notes = snapshotValue["notes"] as! String
//      ref = snapshot.ref
//   }
//   
//   func toAnyObject() -> [String: Any] {
//      return [
//         "contactID": contactID as Any as AnyObject,
//         "name": name as String as AnyObject,
//         "company": company as String as AnyObject,
//         "phone": phone as String as AnyObject,
//         "email": email as String as AnyObject,
//         "contactPhoto": contactPhoto as String as AnyObject,
//         "extra": extra as String as AnyObject,
//         "notes": notes as String as AnyObject,
//         
//      ]
//   }
//}
//
//
//
//extension Date {
//   
//   func format() -> String {
//      return Format.shared.dateFormatter.string(from: self)
//   }
//}
//
//class Format {
//   
//   static let shared = Format()
//   let dateFormatter = DateFormatter()
//   private init() {
//      dateFormatter.dateStyle = .long
//      dateFormatter.timeStyle = .long
//   }
//}
//
//
//class User {
//   
//   var userID: String
//   var groupsID: String
//   var extraID: String
//   var ref: FIRDatabaseReference?
//   
//   init ( userID: String, groupsID: String, extraID: String){
//      
//      self.userID = userID
//      self.groupsID = groupsID
//      self.extraID = extraID
//      
//   }
//   
//   init(snapshot: FIRDataSnapshot) {
//      userID = snapshot.key
//      let snapshotValue = snapshot.value as! [String : AnyObject]
//      groupsID = snapshotValue["groupsID"] as! String
//      extraID = snapshotValue["extraID"] as! String
//      ref = snapshot.ref
//   }
//   
//   func toAnyObject() -> [String: Any] {
//      return [
//         "userID": userID as Any as AnyObject,
//         "groupsID": groupsID as String as AnyObject,
//         "extraID": extraID as String as AnyObject,
//      ]
//   }
//   
//}//END USER
//
//
//class Group {
//   
//   var groupID: String
//   var chat: String
//   var extraID: String
//   var groupimage: String
//   var ref: FIRDatabaseReference?
//   
//   init ( groupID: String, chat: String, extraID: String, groupimage: String ){
//      
//      self.groupID = groupID
//      self.chat = chat
//      self.extraID = extraID
//      self.groupimage = groupimage
//   }
//   
//   init(snapshot: FIRDataSnapshot) {
//      groupID = snapshot.key
//      let snapshotValue = snapshot.value as! [String : AnyObject]
//      chat = snapshotValue["chat"] as! String
//      extraID = snapshotValue["extraID"] as! String
//      groupimage = snapshotValue["groupimage"] as! String
//      ref = snapshot.ref
//   }
//   
//   func toAnyObject() -> [String: Any] {
//      return [
//         "groupID": groupID as Any as AnyObject,
//         "chat": chat as String as AnyObject,
//         "extraID": extraID as String as AnyObject,
//         "groupimage": groupimage as String as AnyObject,
//      ]
//   }
//   
//}//END Group
//
//
////
////
//func createUser(userNumber: String, groups: String = "", extra: String = "" ){
//
//let usersRef = FIRDatabase.database().reference(withPath: "users")
//let user = User(userID: userNumber, groupsID: groups, extraID: extra)
//let userRef = usersRef.child(userNumber)
//userRef.setValue(user.toAnyObject())
//}
//
//
//
//
//// MARK: - FB Read
//func listenForContacts() {
//   // queryOrdered(byChild: "completed")
//   let contact = FIRDatabase.database().reference(withPath: "Contacts")
//   contact.observe(.value, with: didUpdateContacts)
//}
//
//
//// MARK: - FB: Create contact, Delete contact, Update contact
//func createContact(name: String, company: String,phone: String,email: String,image: String = "", extra: String, notes: String) {
//   
//   let contactsRef = FIRDatabase.database().reference(withPath: "contacts")
//   let cotact = Contact(name: name, company: company,phone: phone, email: email,contactPhoto: image, extra: extra, notes: notes)
//   let contactRef = contactsRef.childByAutoId()
//   contactRef.setValue(cotact.toAnyObject())
//}
//
//
//func deleteContact(contact: Contact) {
//   contact.ref?.removeValue()
//}
//
//
//func didUpdateContacts(snapshot: FIRDataSnapshot) {
//   contacts.removeAll()
//   for item in snapshot.children {
//      let contact = Contact(snapshot: item as! FIRDataSnapshot)
//      contacts.append(contact)
//   }
//   print(contacts)
//}
//
//func updateContact(newName: String? = nil, company: String? = nil, phone: String? = nil, email: String? = nil, extra: String? = nil, notes: String? = nil, contact: Contact) {
//   if contactToEdit.name == newName {
//      contactToEdit.ref?.updateChildValues([
//         "company" : company!,
//         "phone": phone!,
//         "email": email!,
//         "extra": extra!,
//         "notes": notes!
//         ])
//   }
//}
////
////
//
//}// END of ContacsViewController
