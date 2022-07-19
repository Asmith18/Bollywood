//
//  AccountViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    var viewModel: DetailsViewModel!

    //MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameTextlabel: UILabel!
    @IBOutlet weak var myFavoritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Account"
        updateViews()
        myFavoritesCollectionView?.dataSource = self
        myFavoritesCollectionView?.delegate = self
        myFavoritesCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out %@", signOutError)
        }
        UserDefaults.standard.removeObject(forKey: "uid")
        UserDefaults.standard.removeObject(forKey: "email")
        UserDefaults.standard.removeObject(forKey: "signedInWithFirebase")
    }
    
    func returnToMovies() {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
       guard let viewController = storyboard.instantiateViewController(withIdentifier: "movies") as? BollywoodViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "settings") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
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
    
    func updateViews() {
        profileImageView.image = UIImage(named: "profile")
        profileNameTextlabel.text = UserDefaults.standard.string(forKey: "email")
    }
}

extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myFavoritesCollectionView.dequeueReusableCell(withReuseIdentifier: "myFav", for: indexPath) as! MyFavoritesCollectionViewCell
        
        cell.posterImageView.image = UIImage(named: "boys")
        cell.posterNameTextLabel.text = "The Boys"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "movieDetails") as? DetailViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}
