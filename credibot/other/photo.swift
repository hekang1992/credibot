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
                        self.showAlert("相机不可用", in: viewController)
                        return
                    }
                    self.imagePickedHandler = completion
                    let picker = UIImagePickerController()
                    picker.sourceType = .camera
                    if type == "1" {
                        picker.cameraDevice = .front
                    }else {
                        picker.cameraDevice = .rear
                    }
                    picker.delegate = self
                    viewController.present(picker, animated: true)
                } else {
                    self.showSettingsAlert("无法访问相机", in: viewController)
                }
            }
        }
    }
    
    private func showSettingsAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: message, message: "请前往设置中开启相机权限", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        vc.present(alert, animated: true)
    }
    
    private func showAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
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


class PhotoLibraryHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var imagePickedHandler: ((UIImage) -> Void)?
    
    func getPhotoLibraryImage(from viewController: UIViewController, completion: @escaping (UIImage) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                if status == .authorized || status == .limited {
                    guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                        self.showAlert("相册不可用", in: viewController)
                        return
                    }
                    self.imagePickedHandler = completion
                    let picker = UIImagePickerController()
                    picker.sourceType = .photoLibrary
                    picker.delegate = self
                    viewController.present(picker, animated: true)
                } else {
                    self.showSettingsAlert("无法访问相册", in: viewController)
                }
            }
        }
    }
    
    private func showSettingsAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: message, message: "请前往设置中开启相册权限", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        })
        vc.present(alert, animated: true)
    }
    
    private func showAlert(_ message: String, in vc: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "确定", style: .default))
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
