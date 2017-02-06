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
   
   var groupName = String ()
   var cModel : ContactModel!
   var mensallo = TextComposer()
   var contacts = [CNContact]()
   var groups = [CNGroup] ()
  

   @IBOutlet weak var mpTableView: UITableView!
   
   

   
   
   //MARK: tableView func
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contacts.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let  cell = tableView.dequeueReusableCell(withIdentifier: "mpTableViewCell", for: indexPath) as? MPTableViewCell
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


    override func viewDidLoad() {
        super.viewDidLoad()
      contacts = Info.shared.fetchContacts()
      mpTableView.reloadData()

    searchForContactsInGroup(groupName: "Friend")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   func searchForContactsInGroup( groupName: String) {
      
      do {
         let store = CNContactStore()
         
         let groups = try store.groups(matching: nil)
         let filteredGroups = groups.filter { $0.name == groupName }
         
         guard let workGroup = filteredGroups.first else {
            print(" fuck No \(groupName) group")
            return
         }
         
         let predicate = CNContact.predicateForContactsInGroup(withIdentifier: workGroup.identifier)
         let keysToFetch = [CNContactGivenNameKey]
         let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
         
         print("this sis the contact .....................\(contacts)")
      }
      catch {
         print("Handle error")
      }
      
   }//END searchForContactsInGroup
   

   
   
    }//END MPtableViewController
