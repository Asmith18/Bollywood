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
    @IBOutlet weak var showPasswordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = true
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
                    let storyboard = UIStoryboard(name: "Movies", bundle: nil)
                    guard let viewController = storyboard.instantiateViewController(withIdentifier: "movies") as? BollywoodViewController else { return }
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "signup") as? SignUpViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func showPasswordButtonPressed(_ sender: Any) {
        if passwordTextField.isSecureTextEntry == true {
            passwordTextField.isSecureTextEntry = false
            showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            passwordTextField.isSecureTextEntry = true
            showPasswordButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
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
