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
  // var selectedGroups = GroupSelected]()

   var groups = [CNGroup]()
   var groupInfo = String ()
   
   @IBOutlet weak var out: UIButton!
   
   @IBAction func outButton(_ sender: UIButton) {
      dismiss(animated: true, completion: nil)
   }
   
   @IBOutlet weak var groupName: UILabel!
   
   
   @IBAction func textOut(_ sender: UIButton) {
      
     
      
   }
   
   @IBAction func emailOut(_ sender: UIButton) {
   }
   
   
   @IBAction func edit(_ sender: UIButton) {
   }
   
   

    override func viewDidLoad() {
        super.viewDidLoad()
     setInfo()
        // Do any additional setup after loading the view.
    }
   
   
   
   private func setInfo() {
      
      groupName.text = groupSelected.name
      groupInfo =  groupSelected.idetifier
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
