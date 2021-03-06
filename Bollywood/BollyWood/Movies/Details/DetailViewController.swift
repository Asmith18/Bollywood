//
//  DetailViewController.swift
//  Bollywood
//
//  Created by adam smith on 5/21/22.
//

import UIKit
import WebKit
import FirebaseAuth

class DetailViewController: UIViewController {
    
    var viewModel: DetailsViewModel!
    var isFavMovie = UserDefaults.standard.bool(forKey: "isFavMovie")

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameTextLabel: UILabel!
    @IBOutlet weak var movieDateTextLabel: UILabel!
    @IBOutlet weak var movieRatingTextLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextField: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var movieProviderCollectionView: UICollectionView!
    @IBOutlet weak var movieTrailerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViews()
        updateViews()
        viewModel.fetchVidCode()
        viewModel.getMoviePoviders()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func collectionViews() {
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
        movieProviderCollectionView?.dataSource = self
        movieProviderCollectionView?.delegate = self
        movieProviderCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
        movieTrailerCollectionView?.dataSource = self
        movieTrailerCollectionView?.delegate = self
        movieTrailerCollectionView?.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    func updateViews() {
        movieDateTextLabel.text = viewModel.movie?.release_date
        movieRatingTextLabel.text = "\(viewModel.movie?.vote_average ?? 0) / 10"
        fetchImage(for: viewModel)
        movieNameTextLabel.text = viewModel.movie?.title
        movieDescriptionTextField.layer.cornerRadius = 25
        if viewModel.movie?.overview != "" {
            movieDescriptionTextField.text = viewModel.movie?.overview
        } else {
            movieDescriptionTextField.text = "No Description Found..."
        }
    }
    
    func fetchImage(for viewModel: DetailsViewModel) {
        guard let tvImage = viewModel.movie?.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.movieImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "email") != nil {
            if isFavMovie {
                favoriteButton.image = UIImage(systemName: "heart")
            } else {
                favoriteButton.image = UIImage(systemName: "heart.fill")
            }
            isFavMovie = !isFavMovie
            UserDefaults.standard.set(isFavMovie, forKey: "isFavMovie")
            UserDefaults.standard.synchronize()
        } else {
            let alertController = UIAlertController(title: "Not Signed In.", message: "Sign In to use this feature.", preferredStyle: .alert)
            let accountAction = UIAlertAction(title: "Sign In", style: .default) { accountAction in
                let storyboard = UIStoryboard(name: "SignIn", bundle: nil)
                guard let viewController = storyboard.instantiateViewController(withIdentifier: "signin") as? SignInViewController else { return }
                self.navigationController?.pushViewController(viewController, animated: true)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(accountAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension DetailViewController: DetailsViewModelDelegate {
    func movieProviderHasData() {
        DispatchQueue.main.async {
            self.movieProviderCollectionView.reloadData()
        }
    }
    
    func vidCodeHasData() {
        DispatchQueue.main.async {
            self.movieTrailerCollectionView.reloadData()
        }
    }
    
    func movieHasData() {
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.movieProviderCollectionView {
            let cell = movieProviderCollectionView.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! MovieProvidersCollectionViewCell
            
            return cell
        } else {
            let cell = movieTrailerCollectionView.dequeueReusableCell(withReuseIdentifier: "trailer", for: indexPath) as! MovieWebKitCollectionViewCell
        
            return cell
        }
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 75, height: 100)
    }
}
