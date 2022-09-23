//
//  MovieDetailController.swift
//  MovieApp
//
//  Created by atit on 20/09/2022.
//

import UIKit
import Kingfisher

final class MovieDetailController: UIViewController {
    
    private let screenView: MovieDetailView
    private let viewModel: MovieDetailViewModel
    
    init(with view: MovieDetailView, viewModel: MovieDetailViewModel) {
        self.screenView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getMovieDetail()
        setup()
    }
    
    override func loadView() {
          super.loadView()
          view = screenView
      }

    private func setup() {
        observeEvent()
    }
    
    private func observeEvent() {
        viewModel.movieDetail.dropFirst().sink { [weak self] movieDetail in
            guard let self = self else { return }
            self.fetchData()
        }.store(in: &viewModel.bag)
    }
    
    private func fetchData() {
        let movieDetail = viewModel.movieDetail.value
        screenView.titleLabel.text = movieDetail?.originalTitle
        screenView.descriptionTextView.text = movieDetail?.overview
        
        if let imageUrl = movieDetail?.backdropPath {
            let imageEndPoint = "https://image.tmdb.org/t/p/w500\(imageUrl)"
            screenView.movieImageView.setImage(urlString: imageEndPoint)
        }
    }
}
