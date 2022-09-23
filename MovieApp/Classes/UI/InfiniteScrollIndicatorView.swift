//
//  InfiniteScrollIndicatorView.swift
//  MovieApp
//
//  Created by atit on 22/09/2022.
//

import UIKit

class InfiniteScrollIndicatorView: UIView {
    
    lazy var activityView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView(style: .medium)
        indicatorView.startAnimating()
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        create()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func create() {
        addSubview(activityView)
        NSLayoutConstraint.activate([
            activityView.topAnchor.constraint(equalTo: topAnchor),
            activityView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityView.bottomAnchor.constraint(equalTo: bottomAnchor),
            activityView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
