//
//  TVViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/27/22.
//

import UIKit

class TVShowViewController: UIViewController {
    
    var viewModel: TVShowsViewModel!
    @IBOutlet var searchBarView: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!

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
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchBarView.isHidden = true
    }
    
    //MARK: - Actions
    @IBAction func accountButtonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "account") as? AccountViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchBarView.isHidden == true {
            searchBarView.isHidden = false
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
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "tvDetails") as? TVShowDetailsViewController else { return }
        viewController.viewModel = TVShowDetailsViewModel(delegate: viewController)
        viewController.viewModel.tvShow = viewModel.results[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}

extension TVShowViewController: TVShowsViewModelDelegate {
    func tvShowHasData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension TVShowViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension TVShowViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    }
}
