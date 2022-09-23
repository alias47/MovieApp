//
//  MovieListController.swift
//  MovieApp
//
//  Created by atit on 19/09/2022.
//

import UIKit
import Kingfisher

final class MovieListController: UIViewController {
    
    private let screenView: MovieListView
    private let viewModel: MovieListViewModel
    
    var color: [Int: UIColor?] = [:]
    
    init(with view: MovieListView, viewModel: MovieListViewModel) {
        self.screenView = view
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getInitialData()
        setup()
        observeEvent()
    }
    
    override func loadView() {
        super.loadView()
        view = screenView
    }
    
    private func setup() {
        setTableView()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 25)]
        title = "Movie App"
    }
    
    private func setTableView() {
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
    }
    
    private func observeEvent() {
        viewModel.movieList.dropFirst().sink { [weak self] movieList in
            guard let self = self else { return }
            self.screenView.tableView.tableFooterView = nil
            self.screenView.tableView.reloadData()
        }.store(in: &viewModel.bag)
        
    }
}

extension MovieListController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movieList.value?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.movieList.value?.results[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieId = viewModel.movieList.value?.results[indexPath.row].id else { return }
        let view = MovieDetailView()
        let viewModel = MovieDetailViewModel(networkManager: viewModel.networkManager, movieId: movieId)
        let controller = MovieDetailController(with: view, viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == ((viewModel.movieList.value?.results.count ?? 0) - 1) && viewModel.canFetchMore  {
            setupFooterView()
            viewModel.getMoreData()
        }
    }
    
    // MARK: setupFooterView
    private func setupFooterView() {
        let indicatorView = InfiniteScrollIndicatorView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.accessibilityFrame.width, height: 30))
        screenView.tableView.tableFooterView = indicatorView
    }
}
