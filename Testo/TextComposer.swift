//
//  TextComposer.swift
//  Testo
//
//  Created by oskar morett on 1/31/17.
//  Copyright © 2017 oskar morett. All rights reserved.
//

import Foundation
import MessageUI
import Contacts


class TextComposer: NSObject, MFMessageComposeViewControllerDelegate {
   
   static let shared = TextComposer()
   
   
   
   override init() {}
   
   var contacts = [CNContact]()
   
   var textMessageRecipients = [String]()
   
   // A wrapper function to indicate whether or not a text message can be sent from the user's device
   func canSendText() -> Bool {
      return MFMessageComposeViewController.canSendText()
   }
   
   // Configures and returns a MFMessageComposeViewController instance
   func configuredMessageComposeViewController() -> MFMessageComposeViewController {
      let messageComposeVC = MFMessageComposeViewController()
      messageComposeVC.messageComposeDelegate = self  //  Make sure to set this property to self, so that the controller can be dismissed!
      messageComposeVC.recipients = textMessageRecipients
      messageComposeVC.body =  "whast up YO!"
      return messageComposeVC
   }
   
   // MFMessageComposeViewControllerDelegate callback - dismisses the view controller when the user is finished with it
   func messageComposeViewController(_ controller: MFMessageComposeViewController!, didFinishWith result: MessageComposeResult) {
      textMessageRecipients = [String] ()
      controller.dismiss(animated: true, completion: nil)
   }
}
