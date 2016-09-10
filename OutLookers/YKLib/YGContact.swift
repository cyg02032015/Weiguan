//
//  YGContact.swift
//  Address
//
//  Created by Youngkook on 16/8/1.
//  Copyright © 2016年 youngkook. All rights reserved.
//

import Foundation
import AddressBook
import Contacts

struct Contact {
    var name: String
    var phone: String
    var pinyin = ""
    
    init(name: String, phone: String) {
        self.name = name
        self.phone = phone
    }
    
    var description: String! {
        return "name = \(name)\nphone = \(phone)"
    }
}

class YGContact {
    lazy var contacts = [Contact]()
    lazy var addressBook: ABAddressBook = {
        let ab = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
        return ab
    }()
    @available(iOS 9.0, *)
    lazy var contactStore: CNContactStore = CNContactStore()
    @available(iOS 9.0, *)
    lazy var cnContacts = [CNContact]()
    
    func getContacts() -> [Contact] {
        //1. 判断是否授权成功, 授权成功才能获取数据
        if #available(iOS 9.0, *) {
            let keys = [CNContactFormatter.descriptorForRequiredKeysForStyle(CNContactFormatterStyle.FullName), CNContactImageDataKey, CNContactPhoneNumbersKey]
            do {
                try self.contactStore.enumerateContactsWithFetchRequest(CNContactFetchRequest(keysToFetch: keys), usingBlock: { (contact, objcBool) in
                    var fullName = CNContactFormatter.stringFromContact(contact, style: .FullName)
                    fullName = fullName?.stringByReplacingOccurrencesOfString(" ", withString: "")
                    for labelValue in contact.phoneNumbers {
                        var phone = (labelValue.value as! CNPhoneNumber).stringValue
                        if phone.hasPrefix("+86") {
                            let phone1: String = phone.substringFromIndex(phone.startIndex.advancedBy(3))
                            phone = phone1
                        }
                        phone = phone.stringByReplacingOccurrencesOfString("-", withString: "")
                        phone = phone.stringByReplacingOccurrencesOfString("(", withString: "")
                        phone = phone.stringByReplacingOccurrencesOfString(")", withString: "")
                        phone = phone.stringByReplacingOccurrencesOfString(" ", withString: "")
                        let obj = Contact(name: fullName!, phone: phone)
                        self.contacts.append(obj)
                    }
                })
            } catch let e {
                print(e)
            }
        } else {
            if ABAddressBookGetAuthorizationStatus() == .Authorized {
                //3. 获取所有联系人
                let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBook).takeRetainedValue() as Array
                for record in allContacts {
                    let currentContact: ABRecordRef = record
                    let currentContactName = ABRecordCopyCompositeName(currentContact)?.takeRetainedValue() as String?
                    if let name = currentContactName {
                        let currentContactPhones: ABMultiValueRef = ABRecordCopyValue(currentContact, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
                        
                        for index in 0..<ABMultiValueGetCount(currentContactPhones){
                            var phone = ABMultiValueCopyValueAtIndex(currentContactPhones, index).takeRetainedValue() as! String
                            if phone.hasPrefix("+86") {
                                let phone1: String = phone.substringFromIndex(phone.startIndex.advancedBy(3))
                                phone = phone1
                            }
                            phone = phone.stringByReplacingOccurrencesOfString("-", withString: "")
                            phone = phone.stringByReplacingOccurrencesOfString("(", withString: "")
                            phone = phone.stringByReplacingOccurrencesOfString(")", withString: "")
                            phone = phone.stringByReplacingOccurrencesOfString(" ", withString: "")
                            
                            let contact = Contact(name: name, phone: phone)
                            contacts.append(contact)
                        }
                    }
                }
            }
        }
        return contacts
    }
    
}
