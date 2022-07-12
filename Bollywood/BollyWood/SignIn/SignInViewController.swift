//
//  SignInViewController.swift
//  Bollywood
//
//  Created by adam smith on 7/12/22.
//

import UIKit

class SignInViewController: UIViewController {
    
    //MARK: - Outlets

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func continueAsGuest(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Movies", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "movies") as? BollywoodViewController else { return }
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
