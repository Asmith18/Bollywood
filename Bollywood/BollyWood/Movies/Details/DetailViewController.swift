//
//  DetailViewController.swift
//  Bollywood
//
//  Created by adam smith on 5/21/22.
//

import UIKit
import WebKit
import Firebase

class DetailViewController: UIViewController {
    
    var viewModel: DetailsViewModel!
    var isFavMovie = UserDefaults.standard.bool(forKey: "isFavMovie")

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieNameTextLabel: UILabel!
    @IBOutlet weak var movieDateTextLabel: UILabel!
    @IBOutlet weak var movieRatingTextLabel: UILabel!
    @IBOutlet weak var movieDescriptionTextField: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var movieTrailerCollectionView: UICollectionView!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViews()
        updateViews()
        fetchEndpoint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func collectionViews() {
        movieTrailerCollectionView?.dataSource = self
        movieTrailerCollectionView?.delegate = self
        actorCollectionView?.dataSource = self
        actorCollectionView?.delegate = self
        crewCollectionView?.dataSource = self
        crewCollectionView?.delegate = self
        genreCollectionView?.dataSource = self
        genreCollectionView?.delegate = self
    }
    
    func fetchEndpoint() {
        viewModel.fetchVidCode()
        viewModel.getMovieCredits()
        viewModel.getMovieDetails()
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
        guard let tvImage = viewModel.movie?.backdrop_path else { return }
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
                UserDefaults.standard.set(isFavMovie, forKey: "isFavMovie")
                UserDefaults.standard.synchronize()
                isFavMovie = !isFavMovie
            }
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
    
    func genresHasData() {
        DispatchQueue.main.async {
            self.genreCollectionView.reloadData()
        }
    }
    
    func movieCrewHasData() {
        DispatchQueue.main.async {
            self.crewCollectionView.reloadData()
        }
    }
    
    func vidCodeHasData() {
        DispatchQueue.main.async {
            self.movieTrailerCollectionView.reloadData()
        }
    }
    
    func movieHasData() {
        updateViews()
    }
    
    func movieCastHasData() {
        DispatchQueue.main.async {
            self.actorCollectionView.reloadData()
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieTrailerCollectionView.self {
            return viewModel.results.count
        } else if collectionView == actorCollectionView.self {
            return viewModel.movieCast.count
        } else if collectionView == crewCollectionView.self {
            return viewModel.movieCrew.count
        } else {
            return viewModel.genres.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       if collectionView == movieTrailerCollectionView.self {
            let cell = movieTrailerCollectionView.dequeueReusableCell(withReuseIdentifier: "trailer", for: indexPath) as! MovieWebKitCollectionViewCell
        
            let result = viewModel.results[indexPath.row]
            cell.getVideo(results: result)
            
            return cell
        } else if collectionView == actorCollectionView.self {
            let cell = actorCollectionView.dequeueReusableCell(withReuseIdentifier: "actor", for: indexPath) as! MovieActorCollectionViewCell
            
            let result = viewModel.movieCast[indexPath.row]
            cell.setup(credits: result)
            
            return cell
        } else if collectionView == crewCollectionView.self {
            let cell = crewCollectionView.dequeueReusableCell(withReuseIdentifier: "crew", for: indexPath) as! MovieCrewCollectionViewCell
            
            let result = viewModel.movieCrew[indexPath.row]
            cell.setup(with: result)
            
            return cell
        } else {
            let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: "genre", for: indexPath) as! MovieGenreCollectionViewCell
            
            let result = viewModel.genres[indexPath.row]
            cell.setup(with: result)
            
            return cell
        }
    }
}
