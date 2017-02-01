//
//  ViewController.swift
//  Testo
//
//  Created by oskar morett on 1/30/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseAuth
import FirebaseCore
import Contacts
import ContactsUI



class SingUpViewController: UIViewController {

   var contactStore = CNContactStore()
 
   var model = ContactModel.shared
   
   
   
   @IBOutlet weak var phoneNumberTextfield: UITextField!
   
   
   
   @IBAction func nextButton(_ sender: UIButton) {
      
      
      let number = phoneNumberTextfield.text
      if number == "" {
         alert(message: "Phone Number")
      } else {
         model.createUser(userNumber: number!)
         let status = CNContactStore.authorizationStatus(for: .contacts)
             if status == .notDetermined {
               contactAcces()
            
               } else if status == .denied {
               let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
            self.present(alert, animated: true, completion: nil)
         }
         
      }
   }
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      let titlelabel = "SignUp"
      title =  titlelabel
      
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         
         self.performSegue(withIdentifier: "toNewGroupVC", sender: self)
      }
      

      

      // Do any additional setup after loading the view, typically from a nib.
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }


   func contactAcces() {
      
      let actionSheet = UIAlertController(title: "Testo Permision ", message: "Testo would like to acces your contacts", preferredStyle: .actionSheet)
      
      actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
         
         self.contactStore.requestAccess(for: .contacts, completionHandler: { (access, accessError) -> Void in
            if access {
               
               self.performSegue(withIdentifier: "toNewGroupVC", sender: self)
            }
            
            
         })
      }))
      
      
      actionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: {(action: UIAlertAction) in
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay, to access contacts go to settings ", preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
         return
         
      }))
      self.present(actionSheet, animated: true, completion: nil)
      
   }// func
   

   
   // to get rid of keyboard by touching the outside of the textfield
   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
      self.view.endEditing(true)
   }
   
   func alert(message: String) {
         let alertController = UIAlertController(title: "\(message.capitalized) is a required field" , message: "Please enter your \(message)", preferredStyle: .alert)
         let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
         alertController.addAction(defaultAction)
         self.present(alertController, animated: true, completion: nil)

      }
      
      
}// END SingUpViewController

