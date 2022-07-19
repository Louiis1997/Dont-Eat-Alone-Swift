//
//  SigninViewController.swift
//  Don't eat alone
//
//  Created by Louis Xia on 14/07/2022.
//

import UIKit

class SigninViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var SigninButton: UIButton!
    @IBOutlet weak var SignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.EmailTextField.placeholder = NSLocalizedString("signin.form.email.placeholder", comment: "")
        self.PasswordTextField.placeholder = NSLocalizedString("signin.form.password.placeholder", comment: "")
        self.SigninButton.setTitle(NSLocalizedString("signin.form.signin.button", comment: ""), for: .normal)
        self.SignupButton.setTitle(NSLocalizedString("signin.form.signup.button", comment: ""), for: .normal)
        self.EmailTextField.delegate = self
        self.PasswordTextField.delegate = self
    }
    
    @IBAction func handleSignin(_ sender: Any) {
        guard let email = self.EmailTextField.text,
              let pwd = self.PasswordTextField.text else {
            self.displayErrorMessage(title: NSLocalizedString("signin.form.alert.title", comment: ""), message: NSLocalizedString("signin.form.alert.invalid", comment: ""))
                  return
        }
        guard email.count > 0 && pwd.count > 0 else {
            self.displayErrorMessage(title: NSLocalizedString("signin.form.alert.title", comment: ""), message: NSLocalizedString("signin.form.alert.invalid", comment: ""))
            return
        }
       // GERER CALL API POUR CONNECTER L'UTILISATEUR Si OK ->
        //self.navigationController?.pushViewController(HomeViewController(), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.EmailTextField {
            self.PasswordTextField.becomeFirstResponder()
        }
        if textField == self.PasswordTextField {
            self.PasswordTextField.resignFirstResponder()
            self.handleSignin(self.SigninButton!)
        }
        return true
    }
    
    func displayErrorMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("signin.form.alert.close", comment: ""), style: .cancel))
        self.present(alert, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) {_ in
                alert.dismiss(animated: true)
            }
        }
    }
    
    @IBAction func handleSignupButton(_ sender: Any) {
        self.navigationController?.pushViewController(SignupViewController(), animated: true)
    }
}
