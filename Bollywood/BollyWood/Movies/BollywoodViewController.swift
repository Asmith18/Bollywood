//
//  BollywoodViewController.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import UIKit

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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
        let storyboard = UIStoryboard(name: "Account", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "account") as? AccountViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchbarView.isHidden == true {
            searchbarView.isHidden = false
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
        return CGSize(width: 200, height: 300)
    }
}

extension BollywoodViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchbarView.text,
              !searchTerm.isEmpty else { return }
        
        viewModel.searchMovie(searchTerm: searchTerm)
    }
}
