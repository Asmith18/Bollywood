//
//  SignUpViewController.swift
//  Bollywood
//
//  Created by adam smith on 7/18/22.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        if emailTextField.text?.isEmpty == true {
            print("No Text entered in email field")
            let alertController = UIAlertController(title: "Error: Email Address Field Empty", message: "Please Enter a Valid Email Address", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        if passwordTextField.text?.isEmpty == true {
            print("No Text Entered in Password Field")
            let alertController = UIAlertController(title: "Error: Password Field is Empty", message: "Please Enter a Valid Password", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let password = passwordTextField.text else { return }
        if validatePassword(password) == false {
            let alertController = UIAlertController(title: "Password is Invalid", message: "Password must contain a minimum of 6 characters and no spaces. Please try again.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(confirmAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        signUp()
    }
    
    func signUp() {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print(error)
                    return
                }
                
                guard let user = authResult?.user else { return }
                UserDefaults.standard.set(true, forKey: "signedInWithFirebase")
                UserDefaults.standard.set(user.uid, forKey: "uid")
                UserDefaults.standard.set(user.email, forKey: "email")
                let storyboard = UIStoryboard(name: "Movies", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "movies") as? BollywoodViewController else { return }
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }
    
    func validatePassword(_ password: String) -> Bool {

        if password.count < 6 {
            return false
        }
        if password.range(of: #"\s+"#, options: .regularExpression) != nil {
            return false
        }
            return true
    }
}
