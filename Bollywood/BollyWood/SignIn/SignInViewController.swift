//
//  SignInViewController.swift
//  Bollywood
//
//  Created by adam smith on 7/18/22.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password) { result, error in
                switch result {
                    
                case .none:
                    let alertController = UIAlertController(title: "Account not found", message: "Please check your Email and Password", preferredStyle: .alert)
                    let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alertController.addAction(confirmAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                case .some(let userDetails):
                    UserDefaults.standard.set(true, forKey: "signedInWithFirebase")
                    print("signed in as", userDetails.user.email!)
                    UserDefaults.standard.set(userDetails.user.uid, forKey: "uid")
                    UserDefaults.standard.set(userDetails.user.email, forKey: "email")
                    let storyboard = UIStoryboard(name: "Account", bundle: nil)
                    guard let viewController = storyboard.instantiateViewController(withIdentifier: "account") as? AccountViewController else { return }
                    self.present(viewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "signup") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
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
