//
//  LaunchScreenViewController.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class LaunchScreenViewController: UIViewController {
   
   var contactStore = CNContactStore()


    override func viewDidLoad() {
        super.viewDidLoad()
    contactAcces()
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
   }
   
   
   
   
   func contactAcces() {
      
      let actionSheet = UIAlertController(title: "Testo Permision ", message: "Testo would like to acces your contacts", preferredStyle: .actionSheet)
      
      actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
         
         self.contactStore.requestAccess(for: .contacts, completionHandler: { (access, accessError) -> Void in
            if access {
               
               self.performSegue(withIdentifier: "toFrontPage", sender: self)
            }
            
            
         })
      }))
      
      actionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: {(action: UIAlertAction) in
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay, to access contacts go to settings ", preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
         return
         
      }))
      
      
   }// func
   
   
   

}// END LounchViewController
