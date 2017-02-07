//
//  MPCollectionViewController.swift
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

class MPCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   
   
   
   var groups = [CNGroup]()
   var contacts = [CNContact]()
   var groupsNames = [String] ()
   let cModel = DataModel.shared

   
   @IBOutlet weak var collectionView: UICollectionView!
   
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
      print(groupsNames.count)
      return groups.count
      
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mpCollectionCell", for: indexPath) as! MPCollectionViewCell
      cell.groupLabel.text = groups[indexPath.row].name
      return cell
   }
   
   //MARK: ViewDidLoad ------------------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      autorization()
      groups = getGRoups()
      collectionView.reloadData()
      
   }//@
   
   
   func getGRoups() -> [CNGroup] {
      
      let store = CNContactStore()
      var allGroups = [CNGroup]()
      do {
         allGroups = try store.groups(matching: nil)
         for groupx in allGroups {
            var groupsId = [String]()
            groupsId.append(groupx.identifier)
            groupsNames.append(groupx.name)
         print ("-------------------------------------------------------------------------")
         print (groupx.name)
         print (groupsNames.count)
         print (groupsId.count)
         groups = allGroups
         }
       } catch {
         print("Error fetching Groups")
         }
   return groups
   }//@
   
   func autorization () {
      
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         collectionView.reloadData()
         
      } else if status == .denied {
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         present(alert, animated: true, completion: nil)
      }
      
   }

   
   
   
   
}//END of MPViewController
