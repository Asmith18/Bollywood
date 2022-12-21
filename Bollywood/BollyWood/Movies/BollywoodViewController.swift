//
//  BollywoodViewController.swift
//  Bollywood
//
//  Created by adam smith on 5/17/22.
//

import UIKit

class BollywoodViewController: UIViewController {
    
    var viewModel: BollywoodViewModel!
    var currentPage = 1
    
    //MARK: - Outlets
    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet var searchbarView: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = BollywoodViewModel(delegate: self)
        viewModel.fetchPopular(page: 1)
        topCollectionView?.dataSource = self
        topCollectionView?.delegate = self
        topCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
        searchBar()
    }
    
    func searchBar() {
        searchbarView.delegate = self
        searchbarView.isHidden = true
        navigationItem.titleView = searchbarView
        topCollectionView.keyboardDismissMode = .onDrag
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.searchbarView.isHidden = true
        self.navigationItem.title = "Most Popular"
        
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchbarView.isHidden == true {
            searchbarView.isHidden = false
            self.navigationItem.title = "Search"
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.results.count - 1 == indexPath.row {
            currentPage += 1
            viewModel.fetchPopular(page: currentPage)
        }
    }
}

extension BollywoodViewController: BollywoodViewModelDelegate {
    func movieListHasData() {
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
        }
    }
    
    
    func searchTermHasData() {
        DispatchQueue.main.async {
            self.topCollectionView?.reloadData()
        }
    }
}

extension BollywoodViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = view.frame.size.height
            let width = view.frame.size.width
        return CGSize(width: width * 0.4, height: height * 0.3)
    }
}

extension BollywoodViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovie(searchTerm: searchText)
    }
}


