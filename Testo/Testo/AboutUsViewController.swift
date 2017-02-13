//
//  AboutUsViewController.swift
//  Testo
//
//  Created by oskar morett on 2/11/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
   
   
   @IBAction func outSurface(_ sender: UIButton) {
   dismiss(animated: true, completion: nil)
   }
   
   @IBOutlet weak var efect: UIImageView!
   
    override func viewDidLoad() {
      super.viewDidLoad()
      efect.layer.cornerRadius = 6
      efect.layer.borderWidth = 2.5

    }

   

   }//@AboutUsViewController
