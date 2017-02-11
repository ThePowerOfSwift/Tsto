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
   var groupData = [CNContact]()
   var groupInfo = String ()
   
   
   @IBOutlet weak var tableView: UITableView!
   @IBOutlet weak var groupName: UILabel!
   
   
   @IBAction func saveButton(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBAction func deleteButton(_ sender: UIButton) {
      

   }
  
   
   
   //MARK: COllection View
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return groupData.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
      let cell = tableView.dequeueReusableCell(withIdentifier: "editVCCell", for: indexPath) as! EditTableViewCell
      let fullname = "\(groupData[indexPath.row].givenName)  \(groupData[indexPath.row].familyName)"
         cell.name.text = fullname
      if groupData[indexPath.row].imageDataAvailable {
         let image = UIImage(data: groupData[indexPath.row].imageData!)
         cell.photo.image = image
         cell.photo.layer.cornerRadius = 8
         cell.photo.layer.borderWidth = 1.5
      }
      return cell
   }//@
   
   
   
   //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        autorization()
        groupInfo =  groupSelected.idetifier
        groupName.text = groupSelected.name
        groupData = cModel.getContactsPerGroup(groupIdentifier: groupInfo)
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
