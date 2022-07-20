//
//  BollywoodViewController.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import UIKit
import FirebaseAuth

class BollywoodViewController: UIViewController {
    
    var viewModel: BollywoodViewModel!
    
    //MARK: - Outlets
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet var searchbarView: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topCollectionView?.dataSource = self
        topCollectionView?.delegate = self
        topCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
        viewModel = BollywoodViewModel(delegate: self)
        viewModel.fetchPopular()
        searchBar()
        SignInAlert()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func searchBar() {
        searchbarView.delegate = self
        navigationItem.titleView = searchbarView
        searchbarView.isHidden = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchbarView.isHidden = true
        viewModel.fetchPopular()
    }
    
    //MARK: - Actions
    @IBAction func profileButtonPressed(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "email") != nil {
            let storyboard = UIStoryboard(name: "Account", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "account") as? AccountViewController else { return }
            self.navigationController?.pushViewController(viewController, animated: false)
        } else {
            let alertController = UIAlertController(title: "Not Signed in", message: "Please sign in to acccess this page.", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Sign in", style: .destructive) { (action: UIAlertAction) in
                let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "signin") as? SignInViewController else { return }
                self.navigationController?.pushViewController(viewController, animated: false)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchbarView.isHidden == true {
            searchbarView.isHidden = false
        }
    }
    
    func SignInAlert() {
        if UserDefaults.standard.string(forKey: "email") != nil {
            viewModel.fetchPopular()
        } else {
            let alertController = UIAlertController(title: "Not Signed In.", message: "Sign In or Continue as a Guest.", preferredStyle: .alert)
            let accountAction = UIAlertAction(title: "Sign In", style: .default) { accountAction in
                let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "signin") as? SignInViewController else { return }
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            let guestAction = UIAlertAction(title: "Continue as Guest", style: .default, handler: nil)
            alertController.addAction(accountAction)
            alertController.addAction(guestAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension BollywoodViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = topCollectionView.dequeueReusableCell(withReuseIdentifier: "topCell", for: indexPath) as! TopCollectionViewCell
        cell.setup(with: viewModel.results[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MovieDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "movieDetails") as? DetailViewController else { return }
        viewController.viewModel = DetailsViewModel(delegate: viewController)
        viewController.viewModel.movie = viewModel.results[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension BollywoodViewController: BollywoodViewModelDelegate {
    func searchTermHasData() {
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
        }
    }
    
    func popularHasData() {
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
        }
    }
}

extension BollywoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 200, height: 300)
    }
}

extension BollywoodViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchbarView.text,
              !searchTerm.isEmpty else { return }
        
        viewModel.searchMovie(searchTerm: searchTerm)
    }
}
