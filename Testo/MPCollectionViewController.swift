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
   
   
   
   var cnGroups = [CNGroup]()
   var contacts = [CNContact]()
   var groupName = String ()
   var cModel : ContactModel!
   var groups = [ "Yo", "yoyo", "YOYOYO", "TO YOYOYO"]
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   
   
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
      print(cnGroups.count)
      
      return cnGroups.count
      
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mpCollectionCell", for: indexPath) as! MPCollectionViewCell
      
      cell.groupLabel.text = cnGroups[indexPath.row].name
      
      return cell
   }
   
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}//END of MPViewController
