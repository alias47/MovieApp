//
//  MovieListView.swift
//  MovieApp
//
//  Created by atit on 19/09/2022.
//

import UIKit

final class MovieListView: UIView {
    
    lazy var movieImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.register(MovieListHeaderCell.self, forHeaderFooterViewReuseIdentifier: MovieListHeaderCell.identifier)
        view.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        view.separatorStyle = .none
        view.allowsMultipleSelection = false
        var frame = CGRect.zero
        frame.size.height = .leastNormalMagnitude
        view.tableHeaderView = UIView(frame: frame)
        view.tableFooterView = UIView(frame: frame)
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func create() {
        generateChildrens()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.create()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieListView {
    
    private func generateChildrens() {
        addSubViews(tableView)
        setConstraints()
    }
    
    private func setConstraints() {
        setMovieTableViewConstraints()
    }
    
    private func setMovieTableViewConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
