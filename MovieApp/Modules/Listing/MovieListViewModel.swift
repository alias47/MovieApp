//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by atit on 19/09/2022.
//

import Foundation
import Combine

final class MovieListViewModel {
    
    var bag = Set<AnyCancellable>()
    
    let networkManager: NetworkManager
    var movieList: MovieList?
    var movie = CurrentValueSubject<[Movie], Never>([])
    var errorMessage = PassthroughSubject<String, Never>()
    
    var canFetchMore: Bool = true
    var currentPage: Int = 1
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    // MARK: getInitialData
    func  getInitialData() {
        currentPage = 1
        canFetchMore = true
        getMovieListRequest()
    }
    
    // MARK: getMoreData
    func getMoreData() {
        currentPage += 1
        getMovieListRequest()
    }
    
    func getMovieListRequest() {
        let endpoint = BaseRouter.getMovieList(currentPage)
        
        guard let url = URL(string: endpoint.url ) else {
            fatalError("Cannot parse to url")
        }
        
        networkManager.request(fromURL: url) {  [weak self] (result: Result<MovieList, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let movieList):
                self.movieList = movieList
                self.canFetchMore = movieList.results.count == 20
                var existingList = self.movie.value
                if self.currentPage == 1 {
                    existingList = movieList.results
                } else {
                    existingList.append(contentsOf: movieList.results)
                }
                self.movie.send(existingList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func observeEvent() {
        
    }
}
