//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by atit on 20/09/2022.
//

import Foundation
import Combine

final class MovieDetailViewModel {
    
    var bag = Set<AnyCancellable>()
    
    let networkManager: NetworkManager
    
    var movieDetail = CurrentValueSubject<MovieDetail?, Never>(nil)
    var errorMessage = PassthroughSubject<String, Never>()
    
    var movieId: Int
    
    init(networkManager: NetworkManager, movieId: Int) {
        self.networkManager = networkManager
        self.movieId = movieId
    }
    
    func getMovieDetail() {
        getMovieDetailRequest(endPoint: BaseRouter.getMovieDetail(movieId))
    }
    
    internal func getMovieDetailRequest(endPoint: Endpoint) {
        guard let url = URL(string: endPoint.url ) else {
            fatalError("Cannot parse to url")
        }
        
        networkManager.request(fromURL: url) { [weak self] (result: Result<MovieDetail, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let movieDetail):
                print(movieDetail)
                self.movieDetail.send(movieDetail)
            case .failure(let error):
                print(error)
            }
        }
    }
  
    func observeEvent() {
        
    }
}

