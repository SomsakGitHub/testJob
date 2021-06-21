//
//  RegisterViewController.swift
//  DTCTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit
import Photos

class RegisterViewController: BaseViewController {
    
    @IBOutlet var usernameTextField: placeHolderTextField!
    @IBOutlet var passwordTextField: placeHolderTextField!
    @IBOutlet var nameTextField: placeHolderTextField!
    @IBOutlet var sernameTextField: placeHolderTextField!
    @IBOutlet var idCardTextField: placeHolderTextField!
    @IBOutlet var phoneTextField: placeHolderTextField!
    @IBOutlet var userImageView: UIImageView!
    
    var userCoreData = UserCoreData()
    
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dismissKeyboardOnView()
    }
    
    @IBAction func imagePickerTouch(_ sender: Any) {
        self.imagePicker.photoGalleryAsscessRequest()
    }
    
    @IBAction func registerTouch(_ sender: Any) {
        if usernameTextField.text == "" || passwordTextField.text == "" || nameTextField.text == "" || sernameTextField.text == "" || idCardTextField.text == "" || phoneTextField.text == "" || userImageView.image == nil{
            self.alertOneAction(title: "กรุณากรอกให้ครบ") {(isCompletion) in
                
            }
        }else{
            let datafetchUserEntity = userCoreData.fetchUserEntity()
            
            let username = datafetchUserEntity.filter { (userEntity) -> Bool in
                return userEntity.username == usernameTextField.text
            }
            
            if username.count > 0 {
                self.alertOneAction(title: "username มีอยู่แล้ว") {(isCompletion) in
                    
                }
            }else{
                saveCoreData()
            }
        }
    }
    
    func saveCoreData(){
        var dataArray: [String] = []
        dataArray.append(usernameTextField.text!)
        dataArray.append(passwordTextField.text!)
        dataArray.append(nameTextField.text!)
        dataArray.append(sernameTextField.text!)
        dataArray.append(idCardTextField.text!)
        dataArray.append(phoneTextField.text!)
        self.userCoreData.saveUserEntity(data: dataArray, image: (userImageView.image?.jpegData(compressionQuality: 1.0))!)
        self.alertOneAction(title: "บันทึกเรียบร้อย") {(isCompletion) in
            
        }
    }
}

// MARK: ImagePickerDelegate
extension RegisterViewController: ImagePickerDelegate {
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        userImageView.image = image
        imagePicker.dismiss()
    }

    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}

class ImagePicker: NSObject {

    private weak var controller: UIImagePickerController?
    weak var delegate: ImagePickerDelegate? = nil

    func dismiss() { controller?.dismiss(animated: true, completion: nil) }
    func present(parent viewController: UIViewController, sourceType: UIImagePickerController.SourceType) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = sourceType
        self.controller = controller
        DispatchQueue.main.async {
            viewController.present(controller, animated: true, completion: nil)
        }
    }
}

protocol ImagePickerDelegate: class {
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType)
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage)
    func cancelButtonDidClick(on imageView: ImagePicker)
}

extension ImagePicker {

    private func showAlert(targetName: String, completion: ((Bool) -> Void)?) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            let alertVC = UIAlertController(title: "Access to the \(targetName)",
                                            message: "Please provide access to your \(targetName)",
                                            preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: { action in
                guard   let settingsUrl = URL(string: UIApplication.openSettingsURLString),
                        UIApplication.shared.canOpenURL(settingsUrl) else { completion?(false); return }
                UIApplication.shared.open(settingsUrl, options: [:]) { [weak self] _ in
                    self?.showAlert(targetName: targetName, completion: completion)
                }
            }))
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completion?(false) }))
            UIApplication.shared.windows.filter { $0.isKeyWindow }.first?
                .rootViewController?.present(alertVC, animated: true, completion: nil)
        }
    }

    func photoGalleryAsscessRequest() {
        PHPhotoLibrary.requestAuthorization { [weak self] result in
            guard let self = self else { return }
            let source = UIImagePickerController.SourceType.photoLibrary
            if result == .authorized {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.imagePicker(self, grantedAccess: result == .authorized, to: source)
                }
            } else {
                self.showAlert(targetName: "photo gallery") { self.delegate?.imagePicker(self, grantedAccess: $0, to: source) }
            }
        }
    }
}

extension ImagePicker: UINavigationControllerDelegate { }

// MARK: UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
            return
        }

        if let image = info[.originalImage] as? UIImage {
            delegate?.imagePicker(self, didSelect: image)
        } else {
            print("Other source")
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        delegate?.cancelButtonDidClick(on: self)
    }
}
