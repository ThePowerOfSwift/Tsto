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
   
   
   
   let cModel = DataModel.shared
   var mensallo = TextComposer()
   var contactsLookup = [[CNContact]]()
   var groups = [CNGroup]()
   var groupNames = [String] ()

   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return groups.count
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


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
