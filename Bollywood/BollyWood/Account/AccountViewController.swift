//
//  AccountViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {
    
    var viewModel: AccountViewModel!

    //MARK: - Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileNameTextlabel: UILabel!
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var showsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Account"
        updateViews()
        collectionViewLayout()
        makeRounded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func makeRounded() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
    }
    
    func collectionViewLayout() {
        moviesCollectionView?.dataSource = self
        moviesCollectionView?.delegate = self
        showsCollectionView?.dataSource = self
        showsCollectionView?.delegate = self
    }
    
    func updateViews() {
        moviesCollectionView.layer.cornerRadius = 25
        showsCollectionView.layer.cornerRadius = 25
        profileNameTextlabel.text = UserDefaults.standard.string(forKey: "email")
    }
    
    func changUsername() {
        let alertController = UIAlertController(title: "Edit Profile", message: "Change Username below", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Username"
        }
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { _ in
            guard let contentTextField = alertController.textFields?.first,
                  let content = contentTextField.text else { return }
            self.profileNameTextlabel.text = content
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    //MARK: - Actions
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "settings") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func editProfileButtonTapped(_ sender: Any) {
        changUsername()
    }
}

extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.moviesCollectionView {
            let cell = moviesCollectionView.dequeueReusableCell(withReuseIdentifier: "movie", for: indexPath) as! MoviesCollectionViewCell

                cell.movieImageView.image = UIImage(named: "Thor")
                cell.movieTextLabel.text = "Thor Love and Thunder"
                return cell
        } else {
            let cell = showsCollectionView.dequeueReusableCell(withReuseIdentifier: "shows", for: indexPath) as! TVShowsCollectionViewCell

                cell.tvImageView.image = UIImage(named: "boys")
                cell.tvTextLabel.text = "The Boys"
                return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == moviesCollectionView.self {
            let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "movieDetails") as? DetailViewController else { return }
            viewController.viewModel = DetailsViewModel(delegate: viewController)
            self.navigationController?.pushViewController(viewController, animated: false)
        } else {
            let storyboard = UIStoryboard(name: "TVDetails", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "show") as? TVShowDetailsViewController else { return }
            self.navigationController?.pushViewController(viewController, animated: false)
        }
    }
}
