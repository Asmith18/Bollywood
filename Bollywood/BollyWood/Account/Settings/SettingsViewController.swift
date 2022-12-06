//
//  SettingsViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func logout() {
//        let firebaseAuth = Auth.auth()
//        do {
//            try firebaseAuth.signOut()
//        } catch let signOutError as NSError {
//            print("Error signing out %@", signOutError)
//        }
//        UserDefaults.standard.removeObject(forKey: "uid")
//        UserDefaults.standard.removeObject(forKey: "email")
//        UserDefaults.standard.removeObject(forKey: "signedInWithFirebase")
    }
    
    func returnToMovies() {
//        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
//       guard let viewController = storyboard.instantiateViewController(withIdentifier: "movies") as? BollywoodViewController else { return }
//        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func accountButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func notificationsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func contactButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func aboutUsButtonPressed(_ sender: Any) {
        
    }
    
    @IBAction func signOutButtonPressed(_ sender: Any) {
        
        let signoutAlert = UIAlertController(title: "Are you sure you want to Sign Out?", message: "This will Sign you Out", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .destructive) { (action: UIAlertAction) in
            self.logout()
            self.returnToMovies()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        signoutAlert.addAction(confirmAction)
        signoutAlert.addAction(cancelAction)
        
        present(signoutAlert, animated: true, completion: nil)
    }
}
