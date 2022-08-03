//
//  TVShowDetailsViewController.swift
//  Bollywood
//
//  Created by adam smith on 6/28/22.
//

import UIKit
import WebKit

class TVShowDetailsViewController: UIViewController {
     
    var viewModel: TVShowDetailsViewModel!
    var isFavShow = UserDefaults.standard.bool(forKey: "isFavShow")
    
    //MARK: - Outlets
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var showNameTextlabel: UILabel!
    @IBOutlet weak var showDateTextLabel: UILabel!
    @IBOutlet weak var showRatingTextLabel: UILabel!
    @IBOutlet weak var showDescriptionTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var providerCollectionView: UICollectionView!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        updateViews()
        viewModel.fetchVidCode()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
//    func getVideo() {
//        if viewModel.tvShow?.id != nil {
//            guard let vidCode = viewModel.results.filter({ $0.type == "Trailer"}).first?.key else { return }
//            let vidCodeBaseURLString = "https://www.youtube.com"
//            guard let baseURL = URL(string: vidCodeBaseURLString) else { return }
//
//            var urlcomponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
//            urlcomponents?.path = "/embed/\(vidCode)"
//            let finalURL = urlcomponents?.url
//            tvShowWebView.load(URLRequest(url: finalURL!))
//        } else {
//            print("no data")
//        }
//    }
    
    func setupCollectionView() {
        providerCollectionView.dataSource = self
        providerCollectionView.delegate = self
        providerCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        trailerCollectionView.dataSource = self
        trailerCollectionView.delegate = self
        trailerCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    func updateViews() {
        fetchImage(for: viewModel)
        showDateTextLabel.text = viewModel.tvShow?.first_air_date
        showNameTextlabel.text = viewModel.tvShow?.name
        showRatingTextLabel.text = "\(viewModel.tvShow?.vote_average ?? 0) / 10"
        showDescriptionTextView.layer.cornerRadius = 25
        if viewModel.tvShow?.overview != "" {
            showDescriptionTextView.text = viewModel.tvShow?.overview
        } else {
            showDescriptionTextView.text = "No Description Found..."
        }
    }
    
    func fetchImage(for viewModel: TVShowDetailsViewModel) {
        guard let tvImage = viewModel.tvShow?.poster_path else { return }
        BollywoodAPI.fetchImage(from: tvImage) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.showImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
        
        if UserDefaults.standard.string(forKey: "email") != nil {
            if isFavShow {
                favoriteButton.image = UIImage(systemName: "heart")
            } else {
                favoriteButton.image = UIImage(systemName: "heart.fill")
            }
            isFavShow = !isFavShow
            UserDefaults.standard.set(isFavShow, forKey: "isFavShow")
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

extension TVShowDetailsViewController: TVShowDetailsViewModelDelegate {
    func tvShowproviderHasData() {
        DispatchQueue.main.async {
            self.providerCollectionView.reloadData()
        }
    }
    
    func vidCodeHasData() {
        DispatchQueue.main.async {
            self.trailerCollectionView.reloadData()
        }
    }
    
    func showHasData() {
        updateViews()
    }
}

extension TVShowDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == providerCollectionView.self {
            let cell = providerCollectionView.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! TVShowPorviderCollectionViewCell
            
            return cell
        } else {
            let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: "trailer", for: indexPath) as! TVShowWebKitCollectionViewCell
            
            return cell
        }
    }
}

extension TVShowDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 75, height: 100)
    }
}
