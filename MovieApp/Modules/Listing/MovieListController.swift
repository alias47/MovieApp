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
    }
    
    private func setTableView() {
        screenView.tableView.delegate = self
        screenView.tableView.dataSource = self
        title = "Movie App"
    }
    
    private func observeEvent() {
        viewModel.movie.dropFirst().sink { [weak self] _ in
            guard let self = self else { return }
            self.screenView.tableView.tableFooterView = nil
            self.screenView.tableView.reloadData()
        }.store(in: &viewModel.bag)
        
    }
}

extension MovieListController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: TableView Cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.movie.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = viewModel.movie.value[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.identifier, for: indexPath) as! MovieListTableViewCell
        cell.configure(movie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieId = viewModel.movie.value[indexPath.row].id
        let view = MovieDetailView()
        let viewModel = MovieDetailViewModel(networkManager: viewModel.networkManager, movieId: movieId)
        let controller = MovieDetailController(with: view, viewModel: viewModel)
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.item == (viewModel.movie.value.count - 1) && viewModel.canFetchMore  {
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
