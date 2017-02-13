//
//  FrontPageViewController.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import Contacts
import ContactsUI


class FrontPageViewController: UIViewController {
   
   var groupSelected : GroupSelected!
   var tvc : MPTableViewController!
   var cvc : MPCollectionViewController!
   var gvc : GroupMenuViewController!
   var evc : EditGroupViewController!
   
   
   @IBAction func newGroup(_ sender: UIButton) {
   }
   
   
   //MARK: VIewDidLoad
   override func viewDidLoad() {
      super.viewDidLoad()
      contactAcces()
      NotificationCenter.default.addObserver(self, selector: #selector(FrontPageViewController.refreshContacts), name: NSNotification.Name(rawValue: "CNContactStoreDidChangeNotification"), object: nil)
   }
   
   func refreshContacts() {
      print("REFRESHING CONTACTS")
      
      DispatchQueue.main.async{
   
      }
   }
   
   override func viewDidAppear(_ animated: Bool) {
      tvc.delageta = cvc
      cvc.delageta = tvc
   }
   
   func contactAcces() {
      let store = CNContactStore()
      let actionSheet = UIAlertController(title: "Testo Permision ", message: "Testo would like to acces your contacts", preferredStyle: .actionSheet)
      
         actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
         store.requestAccess(for: .contacts, completionHandler: { (access, accessError) -> Void in
         if access {
         var status = CNContactStore.authorizationStatus(for: .contacts)
             status = .authorized
            }
         }
      )
   }))
      actionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: {(action: UIAlertAction) in
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay, to access contacts go to settings ", preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
         return
      }))
      present(actionSheet, animated: true, completion: nil)
   }// func
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      switch segue.identifier ?? ""  {
      case "toMenu" :
         let destination = segue.destination as? GroupMenuViewController
         destination?.groupSelected = groupSelected
         case "toTCV" :
         tvc = segue.destination as? MPTableViewController
         case "toCVV" :
         cvc = segue.destination as? MPCollectionViewController
         default : ()
      }
   }
}//@ FrontPageViewController
