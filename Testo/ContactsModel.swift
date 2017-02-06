//
//  ContactsData.swift
//  App Permissions Lab  App Permissions Lab  App Permissions Lab
//
//  Created by oskar morett on 12/16/16.
//  Copyright © 2016 oskar morett. All rights reserved.
//

import Foundation
import Contacts
import ContactsUI




class Info {
   
   static let shared = Info()
   
   private init() {}
   
   var contactStore = CNContactStore()
   
   
   
   func fetchContacts() -> [CNContact] {
      
      var contactsData = [CNContact]()
      
      let keys = [
         CNContactGivenNameKey,
         CNContactFamilyNameKey,
         CNContactBirthdayKey, 
         CNContactOrganizationNameKey,
         CNContactImageDataKey,
         CNContactIdentifierKey,
         CNContactThumbnailImageDataKey,
         CNContactImageDataAvailableKey,
         CNContactEmailAddressesKey,
         CNContactPhoneNumbersKey
      ]
      let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
      do {
         try contactStore.enumerateContacts(with: request) { (contact, stop) in
            contactsData.append(contact)
         }
         
      }
      catch {
         print("unable to fetch contacts")
      }
      
      return contactsData
   }
   
   
   
   
   
}//end of Info Class
