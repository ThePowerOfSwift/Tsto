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
      addContactToGroup(contactIdentifier: contactID, groupName:  groups[indexPath.row].name )
      dismiss(animated: true, completion: nil)
   }


    override func viewDidLoad() {
        super.viewDidLoad()
      autorization()
      groups = getGRoups()
      efect.layer.cornerRadius = 8
      efect.layer.borderWidth = 1.5
      contactID = contactSelecteted.identifier
   }//@
   
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

   
   
   func addContactToGroup(contactIdentifier: String, groupName: String) {
      // creatGroup
      let store = CNContactStore()
      var cotacto = CNContact()
      let groupTo = CNMutableGroup ()
      var grupo = CNGroup()
      groupTo.name = groupName
      grupo = groupTo
         do { let keysToFetch = [CNContactIdentifierKey, CNContactViewController.descriptorForRequiredKeys()] as [Any]
            cotacto = try store.unifiedContact(withIdentifier: contactIdentifier, keysToFetch: keysToFetch as! [CNKeyDescriptor])
         } catch let error{ print(error)}
            let saveRequest2 = CNSaveRequest()
            saveRequest2.addMember(cotacto, to: grupo)
         do {  try store.execute(saveRequest2)
         } catch let error{
            print(error)
         }
         
      }
   

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
