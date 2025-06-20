//
//  photo.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import Photos
import AVFoundation

class CameraHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var imagePickedHandler: ((UIImage) -> Void)?
    
    func getCameraImage(from viewController: UIViewController, type: String, completion: @escaping (UIImage) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                if granted {
                    guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                        self.showAlert("Camera not available", in: viewController)
                        return
                    }
                    self.imagePickedHandler = completion
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    if type == "1" {
                        picker.cameraDevice = .front
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            self.hideChangeButton(in: picker.view)
                        }
                    }else {
                        picker.cameraDevice = .rear
                    }
                    picker.delegate = self
                    viewController.present(picker, animated: true)
                } else {
                    self.showSettingsAlert("Camera unavailable (Permission required)", in: viewController)
                }
            }
        }
    }
    
    private func showSettingsAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: message, message: "Please enable camera permissions in Settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Go to setting", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        vc.present(alert, animated: true)
    }
    
    private func showAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default))
        vc.present(alert, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            imagePickedHandler?(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    private func hideChangeButton(in view: UIView) {
        for subview in view.subviews {
            if let button = subview as? UIButton, String(describing: button).contains("CAMFlipButton") {
                button.isHidden = true
            } else {
                hideChangeButton(in: subview)
            }
        }
    }

}


class PhotoLibraryHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var imagePickedHandler: ((UIImage) -> Void)?
    
    func getPhotoLibraryImage(from viewController: UIViewController, completion: @escaping (UIImage) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                if status == .authorized || status == .limited {
                    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                        self.showAlert("Photos unavailable", in: viewController)
                        return
                    }
                    self.imagePickedHandler = completion
                    let picker = UIImagePickerController()
                    picker.sourceType = .photoLibrary
                    picker.delegate = self
                    viewController.present(picker, animated: true)
                } else {
                    self.showSettingsAlert("Photo album unavailable", in: viewController)
                }
            }
        }
    }
    
    private func showSettingsAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: message, message: "To continue, please grant photo access in Settings", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Go to setting", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        vc.present(alert, animated: true)
    }
    
    private func showAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default))
        vc.present(alert, animated: true)
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            imagePickedHandler?(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
}
