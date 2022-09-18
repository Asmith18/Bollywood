//
//  TVViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import UIKit

class TVShowViewController: UIViewController {
    
    var viewModel: TVShowsViewModel!
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var searchBarView: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        viewModel = TVShowsViewModel(delegate: self)
        viewModel.fetchPopular()
        searchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func searchBar() {
        searchBarView.delegate = self
        navigationItem.titleView = searchBarView
        searchBarView.isHidden = true
    }
    
    func fetchAndReload() {
        viewModel.fetchPopular()
        self.collectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.searchBarView.isHidden = true
        fetchAndReload()
        self.navigationItem.title = "Most Popular"
    }
    
    //MARK: - Actions
    @IBAction func accountButtonPressed(_ sender: Any) {
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
        if searchBarView.isHidden == true {
            searchBarView.isHidden = false
            self.navigationItem.title = "Search"
        }
    }
}

extension TVShowViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tvCell", for: indexPath) as! TVCollectionViewCell
        cell.setup(with: viewModel.results[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "TVDetails", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "show") as? TVShowDetailsViewController else { return }
        viewController.viewModel = TVShowDetailsViewModel(delegate: viewController)
        viewController.viewModel.tvShow = viewModel.results[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension TVShowViewController: TVShowsViewModelDelegate {
    func searchTermHasData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension TVShowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 185, height: 285)
    }
}

extension TVShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBarView.text,
              !searchTerm.isEmpty else { return }
        
        viewModel.searchTVShow(searchTerm: searchTerm)
    }
}
