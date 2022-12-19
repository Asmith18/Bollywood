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
        viewModel = BollywoodViewModel(delegate: self)
        fetchAndReload()
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
    
    func fetchAndReload() {
        viewModel.fetchPopular()
        self.topCollectionView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        self.searchbarView.isHidden = true
        fetchAndReload()
        self.navigationItem.title = "Most Popular"
        
    }
    
    //MARK: - Actions
    @IBAction func profileButtonPressed(_ sender: Any) {
//        if UserDefaults.standard.string(forKey: "email") != nil {
//            let storyboard = UIStoryboard(name: "Account", bundle: nil)
//            guard let viewController = storyboard.instantiateViewController(withIdentifier: "account") as? AccountViewController else { return }
//            self.navigationController?.pushViewController(viewController, animated: false)
//        } else {
//            let alertController = UIAlertController(title: "Not Signed in", message: "Please sign in to acccess this page.", preferredStyle: .alert)
//            let confirmAction = UIAlertAction(title: "Sign in", style: .destructive) { (action: UIAlertAction) in
//                let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
//                guard let viewController = storyboard.instantiateViewController(withIdentifier: "signin") as? SignInViewController else { return }
//                self.navigationController?.pushViewController(viewController, animated: false)
//            }
//            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
//            alertController.addAction(confirmAction)
//            alertController.addAction(cancelAction)
//
//            present(alertController, animated: true, completion: nil)
//        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchbarView.isHidden == true {
            searchbarView.isHidden = false
            self.navigationItem.title = "Search"
        }
    }
    
    func SignInAlert() {
//        if UserDefaults.standard.string(forKey: "email") != nil {
//            viewModel.fetchPopular()
//        } else {
//            let alertController = UIAlertController(title: "Not Signed In.", message: "Sign In or Continue as a Guest.", preferredStyle: .alert)
//            let accountAction = UIAlertAction(title: "Sign In", style: .default) { accountAction in
//                let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
//                guard let viewController = storyboard.instantiateViewController(withIdentifier: "signin") as? SignInViewController else { return }
//                self.navigationController?.pushViewController(viewController, animated: true)
//            }
//            let guestAction = UIAlertAction(title: "Continue as Guest", style: .default, handler: nil)
//            alertController.addAction(accountAction)
//            alertController.addAction(guestAction)
//            self.present(alertController, animated: true, completion: nil)
//            viewModel.fetchPopular()
//        }
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
            // in case you you want the cell to be 40% of your controllers view
        return CGSize(width: width * 0.4, height: height * 0.3)
//        return CGSize(width: 185, height: 285)
    }
}

extension BollywoodViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchMovie(searchTerm: searchText)
    }
}


