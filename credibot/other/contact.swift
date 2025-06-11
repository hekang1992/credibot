//
//  contact.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/10.
//

import Contacts
import ContactsUI
import UIKit

let s3 = "s"
protocol ContactManagerDelegate: AnyObject {
    func contactManagerDidSelect(contact: CNContact)
    func contactManagerDidDenyPermission()
}

class ContactManager: NSObject {
    static let shared = ContactManager()
    
    private let store = CNContactStore()
    weak var delegate: ContactManagerDelegate?

    private override init() {}

    func checkPermissionAndRequest(completion: @escaping (Bool) -> Void) {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            store.requestAccess(for: .contacts) { granted, _ in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false)
        case .limited:
            completion(false)
        @unknown default:
            completion(false)
        }
    }

    func fetchContactsAsync(
        keys: [CNKeyDescriptor] = [
            CNContactGivenNameKey as CNKeyDescriptor,
            CNContactFamilyNameKey as CNKeyDescriptor,
            CNContactPhoneNumbersKey as CNKeyDescriptor
        ],
        completion: @escaping ([CNContact]) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            var contacts = [CNContact]()
            let request = CNContactFetchRequest(keysToFetch: keys)

            do {
                try self.store.enumerateContacts(with: request) { contact, _ in
                    contacts.append(contact)
                }
            } catch {
                print("Failed to fetch contacts:", error)
            }

            DispatchQueue.main.async {
                completion(contacts)
            }
        }
    }

    func presentContactPicker(from viewController: UIViewController) {
        let picker = CNContactPickerViewController()
        picker.delegate = self
        viewController.present(picker, animated: true)
    }

    func showSettingsAlert(from vc: UIViewController, message: String = "Please allow access to Contacts in Settings.") {
        let alert = UIAlertController(title: "Access Denied", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Setting", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsURL) else { return }
            UIApplication.shared.open(settingsURL)
        })
        vc.present(alert, animated: true)
    }
}

extension ContactManager: CNContactPickerDelegate {
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        delegate?.contactManagerDidSelect(contact: contact)
    }

    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
       
    }
}
