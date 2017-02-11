//
//  allContactsCollectionViewCell.swift
//  Testo
//
//  Created by oskar morett on 2/10/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit

class allContactsCollectionViewCell: UICollectionViewCell {
   
   @IBOutlet weak var name: UILabel!
   
   @IBOutlet weak var imageView: UIImageView!
   
   override func prepareForReuse() {
      super.prepareForReuse()
      imageView.image = nil
      name.text = nil
   }

}
