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
    @IBOutlet weak var moviesCollectionView: UICollectionView!
    @IBOutlet weak var showsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Account"
        updateViews()
        collectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func collectionViewLayout() {
        moviesCollectionView?.dataSource = self
        moviesCollectionView?.delegate = self
        moviesCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
        showsCollectionView?.dataSource = self
        showsCollectionView?.delegate = self
        showsCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    func updateViews() {
        moviesCollectionView.layer.cornerRadius = 45
        showsCollectionView.layer.cornerRadius = 45
    }
    
    //MARK: - Actions
    @IBAction func settingsButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Settings", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "settings") as? SettingsViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension AccountViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
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
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "movieDetails") as? DetailViewController else { return }
        viewController.viewModel = DetailsViewModel(delegate: viewController)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension AccountViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}
