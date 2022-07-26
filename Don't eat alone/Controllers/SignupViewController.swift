//
//  SignupViewController.swift
//  Don't eat alone
//
//  Created by Louis Xia on 14/07/2022.
//

import UIKit

class SignupViewController: UIViewController , UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var FirstnameTextField: UITextField!
    @IBOutlet weak var LastnameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PersonalStatementTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var ConfirmPasswordTextField: UITextField!
    @IBOutlet weak var SignupButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.FirstnameTextField.placeholder = NSLocalizedString("signup.form.firstname.placeholder", comment: "")
        self.LastnameTextField.placeholder = NSLocalizedString("signup.form.lastname.placeholder", comment: "")
        self.EmailTextField.placeholder = NSLocalizedString("signup.form.email.placeholder", comment: "")
        self.PersonalStatementTextField.placeholder = NSLocalizedString("signup.form.description.placeholder", comment: "")
        self.PasswordTextField.placeholder = NSLocalizedString("signup.form.password.placeholder", comment: "")
        self.ConfirmPasswordTextField.placeholder = NSLocalizedString("signup.form.confirmpassword.placeholder", comment: "")
        self.SignupButton.setTitle(NSLocalizedString("signup.form.signup.button", comment: ""), for: .normal)
        self.FirstnameTextField.delegate = self
        self.LastnameTextField.delegate = self
        self.EmailTextField.delegate = self
        self.PersonalStatementTextField.delegate = self
        self.PasswordTextField.delegate = self
        self.ConfirmPasswordTextField.delegate = self
    }
    
    @IBAction func handleProfileImage(_ sender: Any) {
        let alert = UIAlertController(title: NSLocalizedString("signup.form.alert.profileimage.title", comment: ""), message: NSLocalizedString("signup.form.alert.profileimage.message", comment: ""), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("signup.form.alert.profileimage.gallery", comment: ""), style: .default, handler: { alert in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                return
            }
            let picker = UIImagePickerController()
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
            
        }))
        alert.addAction(UIAlertAction(title: NSLocalizedString("signup.form.alert.profileimage.camera", comment: ""), style: .default, handler: { alert in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                return
            }
            let picker = UIImagePickerController()
            picker.sourceType = .camera
            picker.allowsEditing = true
            picker.delegate = self
            self.present(picker, animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func handleSignup(_ sender: Any) {
        guard let fn = self.FirstnameTextField.text,
              let ln = self.LastnameTextField.text,
              let email = self.EmailTextField.text,
              let ps = self.PersonalStatementTextField.text,
              let pwd = self.PasswordTextField.text,
              let cpwd = self.ConfirmPasswordTextField.text else {
            self.displayErrorMessage(title: NSLocalizedString("signup.form.alert.title", comment: ""), message: NSLocalizedString("signup.form.alert.invalid", comment: ""))
                  return
        }
        guard fn.count > 0 && ln.count > 0 && email.count > 0 && ps.count > 0 && pwd.count > 0 && cpwd.count > 0 else {
            self.displayErrorMessage(title: NSLocalizedString("signup.form.alert.title", comment: ""), message: NSLocalizedString("signup.form.alert.invalid", comment: ""))
            return
        }
        guard pwd.count >= 6 else {
            self.displayErrorMessage(title: NSLocalizedString("signup.form.alert.title", comment: ""), message: NSLocalizedString("signup.form.alert.invalid.password", comment: ""))
            return
        }
        guard pwd.elementsEqual(cpwd) else {
            self.displayErrorMessage(title: NSLocalizedString("signup.form.alert.title", comment: ""), message: NSLocalizedString("signup.form.alert.invalid.confirmpassword", comment: ""))
            return
        }
        let image : String = ProfileImageView.image?.pngData()?.base64EncodedString() ?? "";
        AuthWebService.shared.AuthRegister(pdp: image, firstName: fn, lastName: ln, email: email, password: pwd, description: ps, completion : { bool in
            if bool == true {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(SigninViewController(), animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    self.displayErrorMessage(title: NSLocalizedString("signin.form.alert.title", comment: ""), message: NSLocalizedString("signin.form.alert.failed", comment: ""))
                }
            }
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.FirstnameTextField {
            self.LastnameTextField.becomeFirstResponder()
        }
        if textField == self.LastnameTextField {
            self.EmailTextField.becomeFirstResponder()
        }
        if textField == self.EmailTextField {
            self.PersonalStatementTextField.becomeFirstResponder()
        }
        if textField == self.PersonalStatementTextField {
            self.PasswordTextField.becomeFirstResponder()
        }
        if textField == self.PasswordTextField {
            self.ConfirmPasswordTextField.becomeFirstResponder()
        }
        if textField == self.ConfirmPasswordTextField {
            self.ConfirmPasswordTextField.resignFirstResponder()
            self.handleSignup(self.SignupButton!)
        }
        return true
    }
    
    func displayErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("signup.form.alert.close", comment: ""), style: .cancel))
        self.present(alert, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {_ in
                alert.dismiss(animated: true)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.ProfileImageView.image = image
        picker.dismiss(animated: true)
    }
}
