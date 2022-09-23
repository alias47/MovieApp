//
//  MovieListTableViewCell.swift
//  MovieApp
//
//  Created by atit on 19/09/2022.
//


import UIKit
import Combine

final class MovieListTableViewCell: UITableViewCell {
    
    // MARK: properites
    var bag = Set<AnyCancellable>()
    
    // MARK: UIs
    lazy var wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "detailColor")
        view.clipsToBounds = true
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var spacer = UIView()
    
    lazy var mainStackView: UIStackView = {
        let ratintStackView = UIStackView(arrangedSubviews: [spacer, ratingImageView, ratingLabel])
        ratintStackView.axis = .horizontal
        ratintStackView.spacing = 6
        ratintStackView.alignment = .center
        ratintStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalStackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel, ratintStackView])
        verticalStackView.axis = .vertical
        verticalStackView.spacing = 6
        verticalStackView.distribution = .fill
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let horizontalStackView = UIStackView(arrangedSubviews: [movieImageView, verticalStackView])
        horizontalStackView.axis = .horizontal
        horizontalStackView.spacing = 8
        horizontalStackView.distribution = .fill
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        return horizontalStackView
    }()
    
    // MARK: overrides
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bag = Set<AnyCancellable>()
        movieImageView.image = nil
    }
    
    // MARK: other functions
    private func setup() {
        generateChildren()
    }
    
    func configure(movie: Movie?) {
        titleLabel.text = movie?.title
        descriptionLabel.text = movie?.overview
        ratingLabel.text = "\(movie?.voteAverage ?? 0)"
        if let imageUrl = movie?.backdropPath {
            let imageEndPoint = "https://image.tmdb.org/t/p/w500\(imageUrl)"
            movieImageView.setImage(urlString: imageEndPoint)
        }
    }
    
}

extension MovieListTableViewCell {
    
    private func generateChildren() {
        contentView.addSubview(wrapperView)
        wrapperView.addSubViews(mainStackView)
        
        setConstraints()
    }
    
    private func setConstraints() {
        setWrapperViewConstrains()
        setStackViewConstrains()
    }
    
    private func setWrapperViewConstrains() {
        NSLayoutConstraint.activate([
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            wrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            wrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    private func setStackViewConstrains() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            mainStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -10),
            mainStackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -10),
            
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            
            ratingImageView.heightAnchor.constraint(equalToConstant: 20),
            ratingImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
