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




class DataModel {
   
   static let shared = DataModel()
   
   private init() {}
   
   var store = CNContactStore()
   
   
   
   
   func autorization (vc: UIViewController) {
      let status = CNContactStore.authorizationStatus(for: .contacts)
      if status == .authorized {
         contactAcces(vc: vc)
      } else if status == .denied {
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay,please go to your setting to allow access ", preferredStyle: UIAlertControllerStyle.alert)
         vc.present(alert, animated: true, completion: nil)
      }
      
   }//@
   
   
   func contactAcces(vc: UIViewController) {
      let store = CNContactStore()
      let actionSheet = UIAlertController(title: "Testo Permision ", message: "Testo would like to acces your contacts", preferredStyle: .actionSheet)
      actionSheet.addAction(UIAlertAction(title: "Yes", style: .default, handler: {(action: UIAlertAction) in
         store.requestAccess(for: .contacts, completionHandler: { (access, accessError) -> Void in
            if access {
               
               var status = CNContactStore.authorizationStatus(for: .contacts)
               status = .authorized
            }
         })
      }))
      
      actionSheet.addAction(UIAlertAction(title: "No", style: .default, handler: {(action: UIAlertAction) in
         let alert = UIAlertController(title: "Oops!", message: "the acces has been denay, to access contacts go to settings ", preferredStyle: UIAlertControllerStyle.alert)
         alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
         vc.present(alert, animated: true, completion: nil)
         return
         
      }))
      vc.present(actionSheet, animated: true, completion: nil)
      
   }// @ func
   
   
   
   
   //MARK: Fetch all contacts in contacts store
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
         CNContactPhoneNumbersKey]
      let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
      do {
         try store.enumerateContacts(with: request) { (contact, stop) in
            contactsData.append(contact)
         }
      }
      catch {
         print("unable to fetch contacts")
      }
      
      return contactsData
   }
   
   
   //MARK: search for all contacts  only in all groups
   func searchForContactsInGroup() ->  [CNContact]{
      var contactsData = [CNContact]()
      let store = CNContactStore()
      var allGroups = [CNGroup]()
      do {
         allGroups = try store.groups(matching: nil)
         for groupx in allGroups {
            var groupsId = [String]()
            groupsId.append(groupx.identifier)
            do {
               let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groupx.identifier)
               let keysToFetch = [CNContactGivenNameKey,
                                  CNContactFamilyNameKey,
                                  CNContactBirthdayKey,
                                  CNContactOrganizationNameKey,
                                  CNContactImageDataKey,
                                  CNContactIdentifierKey,
                                  CNContactThumbnailImageDataKey,
                                  CNContactImageDataAvailableKey,
                                  CNContactEmailAddressesKey,
                                  CNContactPhoneNumbersKey]
               let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
               contactsData += contact
            } catch {
               print(" fuck No \(groupx) group")
            }
         }
         
      } catch {
         print("Error fetching Groups")
      }
      
      return contactsData
   }//END searchForContactsInGroup
   
   //MARK: get contacs in one group
   func getContactsPerGroup(groupIdentifier: String ) ->  [CNContact]{
      var contactsData = [CNContact]()
      let store = CNContactStore()
                  do {
               let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groupIdentifier)
               let keysToFetch = [CNContactGivenNameKey,
                                  CNContactFamilyNameKey,
                                  CNContactBirthdayKey,
                                  CNContactOrganizationNameKey,
                                  CNContactImageDataKey,
                                  CNContactIdentifierKey,
                                  CNContactThumbnailImageDataKey,
                                  CNContactImageDataAvailableKey,
                                  CNContactEmailAddressesKey,
                                  CNContactPhoneNumbersKey]
               let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
               contactsData += contact
            } catch {
               print(" fuck No \(groupIdentifier) group")
            }
      
      
      return contactsData
   }//END searchForContactsInGroup
   
   
   
   func getPhonesInGroup(groupIdentifier: String ) ->  [CNContact]{
      var contactsData = [CNContact]()
      let store = CNContactStore()
      do {
         let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groupIdentifier)
         let keysToFetch = [CNContactPhoneNumbersKey]
         let contact = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
         contactsData += contact
      } catch {
         print(" fuck No \(groupIdentifier) group")
      }
      
      return contactsData
   }
   
   
   
   //MARK: getGroupsId
   func getGroupsId() -> [String] {
      
      let store = CNContactStore()
      var allGroupsID = [String]()
      var allGroups = [CNGroup]()
      do {
         allGroups = try store.groups(matching: nil)
         for groupx in allGroups {
            allGroupsID.append(groupx.identifier)
            print ("-------------------------------------------------------------------------")
            print (groupx.name)
            print (allGroupsID.count)
         }
      } catch {
         print("Error fetching Groups")
      }
      return allGroupsID
   }//@
   
   
   
   //MARK: Get Contacts  Group  by Group
   func getContactsByGroup() ->  [[CNContact]]{
      var contactsData = [[CNContact]]()
      let store = CNContactStore()
      var allGroups = getGroupsId()
      var addding = [CNContact]()
      
      for group in allGroups {
         do {
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: group)
            let keysToFetch = [CNContactGivenNameKey,
                               CNContactFamilyNameKey,
                               CNContactBirthdayKey,
                               CNContactOrganizationNameKey,
                               CNContactImageDataKey,
                               CNContactIdentifierKey,
                               CNContactThumbnailImageDataKey,
                               CNContactImageDataAvailableKey,
                               CNContactEmailAddressesKey,
                               CNContactPhoneNumbersKey]
            let ArrayOfcontacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as [CNKeyDescriptor])
            contactsData.append(ArrayOfcontacts)
            print("this sis the contact .....................\(contactsData.count)")
         } catch {  print(" fuck No  group")
         }
      }
      return contactsData
   }//END searchForContactsInGroup
   
   
   
   
   
   //MARk: Create a new Group
   func addCNGroup (groupName: String) {
      let contactsStore = CNContactStore()
      var newGroup = CNMutableGroup()
      var saveReq = CNSaveRequest()
      newGroup.name = groupName
      saveReq.add(newGroup, toContainerWithIdentifier: nil)
      let error = NSError(domain: "testo creating contact error", code: 9999, userInfo: nil)
      do { try contactsStore.execute(saveReq)
         print ("saved")}
      catch { print("error") }
      
      
   }
   
   //MARK: Create group and addContacts to it
   func addContactToGroup(contactIdentifiers: [String], groupName: String) {
      // creatGroup
      let store = CNContactStore()
      var cotacto = CNContact()
      var grupo = CNGroup()
      var newGroup = CNMutableGroup()
      let saveRequest1 = CNSaveRequest()
      newGroup.name = groupName
      grupo = newGroup
      saveRequest1.add(newGroup, toContainerWithIdentifier: nil)
      do { try store.execute(saveRequest1)
         print ("saved")
      } catch {  let error = NSError(domain: "testo creating contact error", code: 9999, userInfo: nil)
         print("error") }
      //Add contacts to group
      for id in contactIdentifiers  {
         do {
            let keysToFetch = [CNContactIdentifierKey, CNContactViewController.descriptorForRequiredKeys()] as [Any]
            cotacto = try store.unifiedContact(withIdentifier: id, keysToFetch:keysToFetch as! [CNKeyDescriptor])
         } catch let error{ print(error)}
         let saveRequest2 = CNSaveRequest()
         saveRequest2.addMember(cotacto, to: grupo)
         do{
            try store.execute(saveRequest2)
         } catch let error{
            print(error)
         }
         
      }
   }//@addContactToGroup
   
   //MARK: getGroupsNames
   func getGroupsNames() -> [String] {
      let store = CNContactStore()
      var allGroupsNames = [String]()
      var allGroups = [CNGroup]()
      do {
         allGroups = try store.groups(matching: nil)
         for groupx in allGroups {
            allGroupsNames.append(groupx.name)
            print ("-------------------------------------------------------------------------")
            print (groupx.name)
            print (allGroupsNames.count)
         }
      } catch {
         print("Error fetching Groups")
      }
      return allGroupsNames
   }//@getGroupsNames
   
   
   
   
   
   
   
   
}//end of Info Class
