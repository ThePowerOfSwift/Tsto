//
//  EditGroupViewController.swift
//  Pods
//
//  Created by oskar morett on 2/10/17.
//
//

import UIKit
import Foundation
import Contacts
import ContactsUI



class EditGroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   var groupSelected: GroupSelected!
   let cModel = DataModel.shared
   var contactsInGroup = [CNContact]()
   var groupIdetidentifier = String ()
   
   
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var groupName: UILabel!
   
   
   @IBAction func saveButton(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func deleteButton(_ sender: UIButton) {
      print("\n\n\n ***** THIS GROUP TO BE DELETE ******")
      print ("group name:\(groupIdetidentifier)")
      cModel.deleteingCNGroup(groupID: groupIdetidentifier)
      dismiss(animated: true, completion: nil)

   }
  
   
   
   //MARK: COllection View
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return contactsInGroup.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      let cell = tableView.dequeueReusableCell(withIdentifier: "editVCCell", for: indexPath) as! EditTableViewCell
      let fullname = "\(contactsInGroup[indexPath.row].givenName)  \(contactsInGroup[indexPath.row].familyName)"
         cell.name.text = fullname
      if contactsInGroup[indexPath.row].imageDataAvailable {
         let image = UIImage(data: contactsInGroup[indexPath.row].imageData!)
         cell.photo.image = image
         cell.photo.layer.cornerRadius = 8
         cell.photo.layer.borderWidth = 1.5
      }
      return cell
   }//@

   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
         print("\n\n\n ***** CONTACT IN GROUP ******")
         print("GroupInfo: \(groupIdetidentifier)")
         print("\n\n\n ***** CONTACT TO BE REMOVE ******")
         print("Contact Identifier: \(contactsInGroup[indexPath.row].identifier)")
         print("Contact Identifier: \(contactsInGroup[indexPath.row].givenName)")

         cModel.deleteCNContactFromCNGroup(contactIdentifier: contactsInGroup[indexPath.row].identifier , groupID: groupIdetidentifier )
         // deleting contact from group
      }
   }
   
   
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }

   
   //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        autorization()
        groupIdetidentifier =  groupSelected.idetifier
        groupName.text = groupSelected.name
        contactsInGroup = cModel.getContactsPerGroup(groupIdentifier: groupIdetidentifier)
        tableView.reloadData()
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

   
   
   
   
}//@ EditGroupViewController
