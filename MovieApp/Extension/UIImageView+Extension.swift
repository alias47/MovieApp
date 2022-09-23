//
//  UIImageView+Extension.swift
//  MovieApp
//
//  Created by atit on 20/09/2022.
//

import UIKit

extension UIImageView {
    
    func setImage(urlString: String, placeholder: UIImage? = nil) {
        kf.indicatorType = .activity
        (kf.indicator?.view as? UIActivityIndicatorView)?.color = .purple
        kf.setImage(with: URL(string: urlString), placeholder: placeholder, options: .none)
    }
}
