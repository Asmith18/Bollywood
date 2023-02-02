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
    
    //MARK: - Outlets
    @IBOutlet weak var showImageView: MovieImageCache!
    @IBOutlet weak var showNameTextlabel: UILabel!
    @IBOutlet weak var showDateTextLabel: UILabel!
    @IBOutlet weak var showRatingTextLabel: UILabel!
    @IBOutlet weak var showDescriptionTextView: UITextView!
    @IBOutlet weak var providerCollectionView: UICollectionView!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    @IBOutlet weak var actorCollectionView: UICollectionView!
    @IBOutlet weak var crewCollectionView: UICollectionView!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        updateViews()
        fetchEndpoint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setupCollectionView() {
        providerCollectionView.dataSource = self
        providerCollectionView.delegate = self
        trailerCollectionView.dataSource = self
        trailerCollectionView.delegate = self
        actorCollectionView.dataSource = self
        actorCollectionView.delegate = self
        crewCollectionView.dataSource = self
        crewCollectionView.delegate = self
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
    }
    
    func fetchEndpoint() {
        viewModel.fetchVidCode()
        viewModel.getTVProviders()
        viewModel.getTVCredits()
        viewModel.getTVDetails()
    }
    
    func updateViews() {
        showImageView.setImage(using: viewModel.tvShow?.backdrop_path)
        showDateTextLabel.text = viewModel.tvShow?.first_air_date
        showNameTextlabel.text = viewModel.tvShow?.name
        showRatingTextLabel.text = "\(viewModel.tvShow?.vote_average ?? 0) / 10"
        providerCollectionView.layer.cornerRadius = 25
        showDescriptionTextView.layer.cornerRadius = 25
        if viewModel.tvShow?.overview != "" {
            showDescriptionTextView.text = viewModel.tvShow?.overview
        } else {
            showDescriptionTextView.text = "No Description Found..."
        }
    }
}

extension TVShowDetailsViewController: TVShowDetailsViewModelDelegate {
    
    func tvGenresHasData() {
        DispatchQueue.main.async {
            self.genreCollectionView.reloadData()
        }
    }
    
    
    func tvCrewHasData() {
        DispatchQueue.main.async {
            self.crewCollectionView.reloadData()
        }
    }
    
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
    
    func tvCastHasData() {
        DispatchQueue.main.async {
            self.actorCollectionView.reloadData()
        }
    }
}

extension TVShowDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == providerCollectionView.self {
            if viewModel.flatrate.count == 0 {
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                emptyLabel.text = "No Data"
                emptyLabel.textAlignment = NSTextAlignment.center
                self.providerCollectionView.backgroundView = emptyLabel
                return 0
            } else {
                self.providerCollectionView.backgroundView = nil
                return viewModel.flatrate.count
            }
        } else if collectionView == trailerCollectionView.self {
            if viewModel.results.count == 0 {
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                emptyLabel.text = "No Data"
                emptyLabel.textAlignment = NSTextAlignment.center
                self.trailerCollectionView.backgroundView = emptyLabel
                return 0
            } else {
                self.trailerCollectionView.backgroundView = nil
                return viewModel.results.count
            }
        } else if collectionView == actorCollectionView.self {
            if viewModel.tvCast.count == 0 {
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                emptyLabel.text = "No Data"
                emptyLabel.textAlignment = NSTextAlignment.center
                self.actorCollectionView.backgroundView = emptyLabel
                return 0
            } else {
                self.actorCollectionView.backgroundView = nil
                return viewModel.tvCast.count
            }
        } else if collectionView == crewCollectionView.self {
            if viewModel.tvCrew.count == 0 {
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                emptyLabel.text = "No Data"
                emptyLabel.textAlignment = NSTextAlignment.center
                self.crewCollectionView.backgroundView = emptyLabel
                return 0
            } else {
                self.crewCollectionView.backgroundView = nil
                return viewModel.tvCrew.count
            }
        } else {
            if viewModel.genres.count == 0 {
                let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
                emptyLabel.text = "No Data"
                emptyLabel.textAlignment = NSTextAlignment.center
                self.genreCollectionView.backgroundView = emptyLabel
                return 0
            } else {
                self.genreCollectionView.backgroundView = nil
                return viewModel.genres.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == providerCollectionView.self {
            let cell = providerCollectionView.dequeueReusableCell(withReuseIdentifier: "provider", for: indexPath) as! TVShowPorviderCollectionViewCell
            
            let result = viewModel.flatrate[indexPath.row]
            cell.setup(with: result)
            
            return cell
        } else if collectionView == trailerCollectionView.self {
            let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: "trailer", for: indexPath) as! TVShowWebKitCollectionViewCell
            
            let result = viewModel.results[indexPath.row]
            cell.getVideo(results: result)
            
            return cell
        } else if collectionView == actorCollectionView.self {
            let cell = actorCollectionView.dequeueReusableCell(withReuseIdentifier: "actor", for: indexPath) as! ActorCollectionViewCell
    
                let result = viewModel.tvCast[indexPath.row]
                cell.setup(with: result)
            
            return cell
        } else if collectionView == crewCollectionView.self {
            let cell = crewCollectionView.dequeueReusableCell(withReuseIdentifier: "crew", for: indexPath) as! CrewCollectionViewCell
            
                let result = viewModel.tvCrew[indexPath.row]
                cell.setup(with: result)
            
            return cell
        } else {
            let cell = genreCollectionView.dequeueReusableCell(withReuseIdentifier: "genre", for: indexPath) as! GenreCollectionViewCell
            
            let result = viewModel.genres[indexPath.row]
            cell.setup(with: result)
            
            return cell
        }
    }
}
