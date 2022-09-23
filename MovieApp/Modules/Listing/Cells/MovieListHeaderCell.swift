//
//  MovieListHeaderCell.swift
//  MovieApp
//
//  Created by atit on 20/09/2022.
//

import UIKit
import Combine

final class MovieListHeaderCell: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        generateChildrens()
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        generateChildrens()
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Movie List"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension MovieListHeaderCell {
    
    private func generateChildrens() {
        addSubview(contentView)
        contentView.addSubViews(titleLabel)
        setConstraints()
    }
    
    private func setConstraints() {
        setTitleLabelConstraints()
    }
    
    private func setTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}
