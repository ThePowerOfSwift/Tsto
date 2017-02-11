//
//  GroupMenuViewController.swift
//  Testo
//
//  Created by oskar morett on 2/7/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class GroupMenuViewController: UIViewController {
   
   var groupSelected: GroupSelected!
   let cModel = DataModel.shared
   var mensallo = TextComposer()
   var phonesData = [CNContact]()
   var groups = [CNGroup]()
   var groupInfo = String ()
   //MARK: Outlets
   @IBOutlet weak var out: UIButton!
   @IBOutlet weak var groupName: UILabel!
   @IBOutlet weak var menuView: UIView!
   
   
   @IBOutlet weak var efect: UIImageView!
   
   
   @IBOutlet weak var messegeTextfield: UITextField!
   
   
   //MARK: Buttons
   @IBAction func outButton(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   @IBAction func privateText(_ sender: UIButton) {// individual text to a group of contacts
      sendInvidualTextToAGroup(mensage: messegeTextfield.text!)
   }
   @IBAction func textOut(_ sender: UIButton) {// as Group Chat
      sendaGroupText(mensage: messegeTextfield.text!)
   }//@ TEXTING Button
   @IBAction func emailOut(_ sender: UIButton) {
   }
   @IBAction func edit(_ sender: UIButton) {
      
      //frontPageVC.groupSelected = GroupSelected(name: groups[indexPath.item].name, idetifier: groups[indexPath.item].identifier)
      self.performSegue(withIdentifier: "toEdit", sender: self)

      
   }
   
   
   //MARK: ViewDidLoad   --------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      setInfo()
      efect.layer.cornerRadius = 8
      efect.layer.borderWidth = 1.5
      
   }//@
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if let destination = segue.destination as? EditGroupViewController{
            destination.groupSelected = groupSelected
      }
   }
   
  
   
//
   private func setInfo() {
      groupName.text = groupSelected.name
      groupInfo =  groupSelected.idetifier
      phonesData = cModel.getPhonesInGroup(groupIdentifier: groupInfo)
   }
   

   
   //MARK: send Invidual Text To A Group
   func sendInvidualTextToAGroup(mensage: String) {
      if (mensallo.canSendText()) { // Make sure the device can send text messages
         var phonesStrings = [String]()
            for phoneNumber in phonesData {// 1st loop
               for numeber in phoneNumber.phoneNumbers { // 2loop
                  if let phoneNumberStruct = numeber.value as? CNPhoneNumber {
                     let phoneNumberString = phoneNumberStruct.stringValue
                     phonesStrings.append(phoneNumberString)
                     
                  }
               }//@2loop
            }//@1loop
         for send in phonesStrings{
            mensallo.textMessageRecipients.append(send)
            print (mensallo.textMessageRecipients)
            print (mensallo.textMessageRecipients.count)
         if mensallo.textMessageRecipients.count > 0 {
               let messageComposeVC = mensallo.configuredMessageComposeViewController(mesage: mensage)
                  // Obtain a configured MFMessageComposeViewController
               present(messageComposeVC, animated: true, completion: nil)// Present the configured MFMessageComposeViewController instance
            }
         }
      } else {// Let the user know if his/her device isn't able to send text messages
               let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
               errorAlert.show()
            }
   }//@sendindGroupText
      
  
    //MARK: send and Group Text as groupchat
   func sendaGroupText(mensage: String) {
         if (mensallo.canSendText()) { // Make sure the device can send text messages
               for phoneNumber in phonesData {  // 1st loop
                  for numeber in phoneNumber.phoneNumbers {// 2loop
                     if let phoneNumberStruct = numeber.value as? CNPhoneNumber {
                        let phoneNumberString = phoneNumberStruct.stringValue
                        mensallo.textMessageRecipients.append(phoneNumberString)
                        print (phoneNumberString)
                        print (mensallo.textMessageRecipients.count)
                     }
                  }//@ 2loop
               }// 1st loop
               if mensallo.textMessageRecipients.count > 0 {
                  let messageComposeVC = mensallo.configuredMessageComposeViewController(mesage: mensage)// Obtain a configured MFMessageComposeViewController
                  present(messageComposeVC, animated: true, completion: nil)// Present the configured MFMessageComposeViewController instance
               } else {// Let the user know if his/her device isn't able to send text messages
                  let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
                  errorAlert.show()
               }
         }
      
   }// @sendindindIvidualTextToAGroup
   
   
}//@GroupMenuViewController
