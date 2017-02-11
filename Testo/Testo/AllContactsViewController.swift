//
//  AllContactsViewController.swift
//  Testo
//
//  Created by oskar morett on 2/10/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import Foundation
import Contacts
import ContactsUI


//struct ImageToDisplay {
//
//   var imageName: String
//}

class AllContactsViewController: UIViewController, UICollectionViewDataSource,  UICollectionViewDelegate {
   
   
   let cModel = DataModel.shared
   var mensallo = TextComposer()
   var contacts: [CNContact] = []
   let gridFlowLayout = ContactsGridFlowLayout()/// Flow layout that displays cells with a Grid layout
   let listFlowLayout = ContactsListFlowLayout()/// Flow layout that displays cells with a List layout, like in a tableView
   
   /// True if the current flow layout is a grid
   var isGridFlowLayoutUsed: Bool = false {
      didSet {
         listButton.alpha = (isGridFlowLayoutUsed == true) ? 0.9 : 1.0
         gridButton.alpha = (isGridFlowLayoutUsed == true) ? 1.0 : 0.9
      }
   }
   
   
   
   
   @IBOutlet weak var collectionView: UICollectionView!
   @IBOutlet weak var profileTitleLabel: UILabel!
   @IBOutlet var detailLabel: UILabel!
   // @IBOutlet var profileImageView: UIImageView!
   @IBOutlet var headerView: UIView!
   @IBOutlet var gridButton: UIButton!
   @IBOutlet var listButton: UIButton!
   
   
   //MARK: change to list layout
   @IBAction func listButtonPressed() {
      isGridFlowLayoutUsed = false
      UIView.animate(withDuration: 0.2, animations: { () -> Void in
         self.collectionView.collectionViewLayout.invalidateLayout()
         self.collectionView.setCollectionViewLayout(self.listFlowLayout, animated: true)
      })
   }
   
   
   //MARK: change to grid layout
   @IBAction func gridButtonPressed() {
      isGridFlowLayoutUsed = true
      UIView.animate(withDuration: 0.2, animations: { () -> Void in
         self.collectionView.collectionViewLayout.invalidateLayout()
         self.collectionView.setCollectionViewLayout(self.gridFlowLayout, animated: true)
      })
   }
   
   func setupInitialLayout() {
      isGridFlowLayoutUsed = true
      collectionView.collectionViewLayout = gridFlowLayout
   }
   
   // MARK: collectionView methods
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allContactsCell", for: indexPath) as! allContactsCollectionViewCell
      //name
      let fullname = "\(contacts[indexPath.item].givenName)  \(contacts[indexPath.item].familyName)"
      cell.name.text  =  fullname
      //photo
      if contacts[indexPath.item].imageDataAvailable {
         let image = UIImage(data: contacts[indexPath.row].imageData!)
         cell.imageView.image = image
      }
      
      return cell
   }
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return contacts.count
   }
   
   override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
      collectionView.collectionViewLayout.invalidateLayout()
   }
   
   override var preferredStatusBarStyle : UIStatusBarStyle {
      return .default
   }
   
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "allContactsCell", for: indexPath) as! allContactsCollectionViewCell
      
      for phoneNumber in contacts[indexPath.item].phoneNumbers {
         if let phoneNumberStruct = phoneNumber.value as? CNPhoneNumber {
            let phoneNumberString = phoneNumberStruct.stringValue
            cell.number = phoneNumberString
            print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%")
            print(cell.number)
         
         }
      }
   }
   
   
   // MARK: ViewDidLoad ----------------------------------------------------------------------------------------
   override func viewDidLoad() {
      super.viewDidLoad()
      //     profileImageView.layer.cornerRadius = profileImageView.frame.height/2
      autorization()
      contacts = cModel.fetchContacts()
      setupInitialLayout()
      detailLabel.text = "\(contacts.count)" + " contacts"
      collectionView.reloadData()
   }
   
   
   
   
   //MARK: Autorization
   func autorization () {
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         collectionView.reloadData()
      } else if status == .denied {
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         present(alert, animated: true, completion: nil)
      }
      
   }
   
   
   
   
   
   
}// @

//extension AllContactsViewController : CellTextDelegate{
//   
//   
//   func callButtonPressed(phNumber: String){
//      
//   }
//
//}






