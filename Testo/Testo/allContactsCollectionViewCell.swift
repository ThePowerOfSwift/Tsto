//
//  allContactsCollectionViewCell.swift
//  Testo
//
//  Created by oskar morett on 2/10/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import UIKit
import ContactsUI
import Contacts


class allContactsCollectionViewCell: UICollectionViewCell {
   
   let cModel = DataModel.shared
   let mensallo = TextComposer()
   var number = String ()
   
   @IBOutlet weak var name: UILabel!
   @IBOutlet weak var imageView: UIImageView!
   @IBOutlet weak var text: UIButton!
   @IBOutlet weak var call: UIButton!
   
   @IBAction func textButton(_ sender: Any) {
      if (mensallo.canSendText()) { // Make sure the device can send text messages
         if  number != nil {
            print("%%%%%%%%%%%% SENDING A MESSEGE TO :   %%%%%%%%%%%%%%%%%%%")
            print("THIS \(number)")
            mensallo.textMessageRecipients.append(number)
            let messageComposeVC = mensallo.configuredMessageComposeViewController(mesage: " ")
            let fromVC = AllContactsViewController()
            fromVC.present(messageComposeVC, animated: true, completion: nil)
         }
      } else {
         let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
         errorAlert.show()
      }
   }//@text button
   
   @IBAction func callButton(_ sender: UIButton) {
         var filteredString = String()
         if  number != nil {
         let numericSet = "0123456789"
         let filteredCharacters = number.characters.filter { return numericSet.contains(String($0))}
             filteredString = String(filteredCharacters)
         }
      guard let number = URL(string: "telprompt://" + filteredString ) else { return }
      UIApplication.shared.open(number, options: [:], completionHandler: nil)
   }//@
   
   
   override func prepareForReuse() {
      super.prepareForReuse()
      imageView.image = nil
      name.text = nil
   }
   
}
//
//extension allContactsCollectionViewCell : CellTextDelegate{
//
//
//   func callButtonPressed(phNumber: String){
//
//   }
//
//
//}

