//
//  ProductDataModel.swift
//  EatFreshNY
//
//  Created by Richel Cuyler on 1/18/17.
//  Copyright © 2017 Grace Yu. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import Contacts
import ContactsUI


var contacts = [Contact]()  // needed?
var contactToEdit: Contact!
var groups = [Group]()

var ref: FIRDatabaseReference! // needed?


//PRODUCT CLASS:


class Contact {
   
   var contactID: String?
   var name: String
   var company: String
   var phone: String
   var email: String
   var contactPhoto: String
   var extra: String
   var notes: String
   
   var ref: FIRDatabaseReference?
   
   init(name: String, company: String, phone: String, email: String, contactPhoto: String, extra: String, notes: String) {
      self.name = name
      self.company = company
      self.phone = phone
      self.email = email
      self.contactPhoto = contactPhoto
      self.extra = extra
      self.notes = notes
      
   }
   
   init(snapshot: FIRDataSnapshot) {
      contactID = snapshot.key
      let snapshotValue = snapshot.value as! [String : AnyObject]
      name = snapshotValue["name"] as! String
      company = snapshotValue["company"] as! String
      phone = snapshotValue["phone"] as! String
      email = snapshotValue["email"] as! String
      contactPhoto = snapshotValue["contactPhoto"] as! String
      extra = snapshotValue["extra"] as! String
      notes = snapshotValue["notes"] as! String
            ref = snapshot.ref
   }
   
   func toAnyObject() -> [String: Any] {
      return [
         "contactID": contactID as Any as AnyObject,
         "name": name as String as AnyObject,
         "company": company as String as AnyObject,
         "phone": phone as String as AnyObject,
         "email": email as String as AnyObject,
         "contactPhoto": contactPhoto as String as AnyObject,
         "extra": extra as String as AnyObject,
         "notes": notes as String as AnyObject,
        
      ]
   }
}



extension Date {
   
   func format() -> String {
      return Format.shared.dateFormatter.string(from: self)
   }
}

class Format {
   
   static let shared = Format()
   let dateFormatter = DateFormatter()
   private init() {
      dateFormatter.dateStyle = .long
      dateFormatter.timeStyle = .long
   }
}


class User {
   
   var userID: String
   var groupsID: String
   var extraID: String
   var ref: FIRDatabaseReference?
   
   init ( userID: String, groupsID: String, extraID: String){
      
      self.userID = userID
      self.groupsID = groupsID
      self.extraID = extraID
      
   }
   
   init(snapshot: FIRDataSnapshot) {
      userID = snapshot.key
      let snapshotValue = snapshot.value as! [String : AnyObject]
      groupsID = snapshotValue["groupsID"] as! String
      extraID = snapshotValue["extraID"] as! String
      ref = snapshot.ref
   }
      
      func toAnyObject() -> [String: Any] {
         return [
            "userID": userID as Any as AnyObject,
            "groupsID": groupsID as String as AnyObject,
            "extraID": extraID as String as AnyObject,
         ]
      }

}//END USER


class Group {
   
   var groupID: String
   var chat: String
   var extraID: String
   var groupimage: String
   var ref: FIRDatabaseReference?
   
   init ( groupID: String, chat: String, extraID: String, groupimage: String ){
      
      self.groupID = groupID
      self.chat = chat
      self.extraID = extraID
      self.groupimage = groupimage
   }
   
   init(snapshot: FIRDataSnapshot) {
      groupID = snapshot.key
      let snapshotValue = snapshot.value as! [String : AnyObject]
      chat = snapshotValue["chat"] as! String
      extraID = snapshotValue["extraID"] as! String
      groupimage = snapshotValue["groupimage"] as! String
      ref = snapshot.ref
   }
   
   func toAnyObject() -> [String: Any] {
      return [
         "groupID": groupID as Any as AnyObject,
         "chat": chat as String as AnyObject,
         "extraID": extraID as String as AnyObject,
         "groupimage": groupimage as String as AnyObject,
      ]
   }
   
   }//END Group




//PRODUCT MODEL:

   class ContactModel {
   
   
   static let shared = ContactModel()
   private init() {}
   
   func createUser(userNumber: String, groups: String = "", extra: String = "" ){
      
      let usersRef = FIRDatabase.database().reference(withPath: "users")
      let user = User(userID: userNumber, groupsID: groups, extraID: extra)
      let userRef = usersRef.child(userNumber)
      userRef.setValue(user.toAnyObject())
   }
   
   
   
   
   // MARK: - FB Read
   func listenForContacts() {
      // queryOrdered(byChild: "completed")
      let contact = FIRDatabase.database().reference(withPath: "Contacts")
      contact.observe(.value, with: didUpdateContacts)
   }
   
   
   // MARK: - FB: Create contact, Delete contact, Update contact
   func createContact(name: String, company: String,phone: String,email: String,image: String = "", extra: String, notes: String) {
      
      let contactsRef = FIRDatabase.database().reference(withPath: "contacts")
      let cotact = Contact(name: name, company: company,phone: phone, email: email,contactPhoto: image, extra: extra, notes: notes)
      let contactRef = contactsRef.childByAutoId()
      contactRef.setValue(cotact.toAnyObject())
   }
   
   
   func deleteContact(contact: Contact) {
      contact.ref?.removeValue()
   }
   
   
   func didUpdateContacts(snapshot: FIRDataSnapshot) {
      contacts.removeAll()
      for item in snapshot.children {
         let contact = Contact(snapshot: item as! FIRDataSnapshot)
         contacts.append(contact)
      }
      print(contacts)
   }
   
   func updateContact(newName: String? = nil, company: String? = nil, phone: String? = nil, email: String? = nil, extra: String? = nil, notes: String? = nil, contact: Contact) {
      if contactToEdit.name == newName {
         contactToEdit.ref?.updateChildValues([
            "company" : company!,
            "phone": phone!,
            "email": email!,
            "extra": extra!,
            "notes": notes!
            ])
      }
   }
      
   //MARK:  Adding new group  to contacts( no contacts on it!)
      
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
      
      
   //search fro  contact in groups
      func searchForContactsInGroup( groupName: String) {
         
         do {
            let store = CNContactStore()
            
            let groups = try store.groups(matching: nil)
            let filteredGroups = groups.filter { $0.name == groupName }
            
            guard let workGroup = filteredGroups.first else {
               print("No Work group")
               return
            }
            
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: workGroup.identifier)
            let keysToFetch = [CNContactGivenNameKey]
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
            
            print(contacts)
         }
         catch {
            print("Handle error")
         }
         
      }//END searchForContactsInGroup
      
 
      
      
      
}// END ContactModel
