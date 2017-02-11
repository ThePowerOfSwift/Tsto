//
//  EditTableViewCell.swift
//  Testo
//
//  Created by oskar morett on 2/10/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit

class EditTableViewCell: UITableViewCell {
   
   
   
   @IBOutlet weak var photo: UIImageView!
   
   
   @IBOutlet weak var name: UILabel!
   
   

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
   
   override func prepareForReuse() {
      
      super.prepareForReuse()
      
      photo.image = nil
      
      name.text = nil
      
   }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
