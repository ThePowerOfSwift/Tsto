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
   
   
   
   var groups = [ "Family", "Friends", "Coworkers", "Work", "Employees", "class Mates"]
   
   
   @IBOutlet weak var collectionView: UICollectionView!
   
   
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return groups.count
   }
   
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mpCollectionCell", for: indexPath) as! MPCollectionViewCell
      
      cell.groupLabel.text = groups[indexPath.row]
      
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
