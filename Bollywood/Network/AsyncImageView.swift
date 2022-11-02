//
//  AsyncImageView.swift
//  Bollywood
//
//  Created by adam smith on 10/19/22.
//

import Foundation
import UIKit

//class AsyncImageView: UIImageView {
//    private let service = BollywoodAPI()
//    func fetchImage(from url: URL) {
//        let request = URLRequest(url: url)
//        service.perform(request) { [weak self] result in
//            switch result {
//            case .failure(let error):
//                print(error)
//            case .success(let imageData):
//                guard let image = UIImage(data: imageData) else { return }
//                DispatchQueue.main.async {
//                    self?.contentMode = .scaleAspectFill
//                    self?.image = image
//                }
//            }
//        }
//    }
//}
