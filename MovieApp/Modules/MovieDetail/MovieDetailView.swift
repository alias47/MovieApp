//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by atit on 20/09/2022.
//

import UIKit

final class MovieDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.create()
        backgroundColor = UIColor(named: "detailColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, movieImageView, overViewLabel, descriptionTextView])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var overViewLabel: UILabel = {
        let label = UILabel()
        label.text = "Overview"
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.font = UIFont(name: "HelveticaNeue", size: 14)
        textView.backgroundColor = .clear
        textView.textAlignment = .justified
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
        
    private func create() {
        generateChildrens()
    }
}

extension MovieDetailView {
    
    private func generateChildrens() {
        addSubViews(mainStackView)
        setConstraints()
    }
    
    private func setConstraints() {
        setMainStackConstraints()
    }
    
    private func setMainStackConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            mainStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 50),
            movieImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}
