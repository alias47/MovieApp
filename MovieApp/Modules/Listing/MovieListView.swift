//
//  MovieListView.swift
//  MovieApp
//
//  Created by atit on 19/09/2022.
//

import UIKit

final class MovieListView: UIView {
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.register(MovieListHeaderCell.self, forHeaderFooterViewReuseIdentifier: MovieListHeaderCell.identifier)
        view.register(MovieListTableViewCell.self, forCellReuseIdentifier: MovieListTableViewCell.identifier)
        view.separatorStyle = .none
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
