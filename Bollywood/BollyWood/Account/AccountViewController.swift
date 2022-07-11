//
//  AccountViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/30/22.
//

import UIKit

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
    
    //MARK: - Actions
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "settings") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    func updateViews() {
        myFavoritesCollectionView.layer.cornerRadius = 25
        profileImageView.image = UIImage(named: "profile")
        profileNameTextlabel.text = "Adam"
    }
}

extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = myFavoritesCollectionView.dequeueReusableCell(withReuseIdentifier: "myFav", for: indexPath) as! MyFavoritesCollectionViewCell
        
        cell.posterImageView.layer.cornerRadius = 20
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
