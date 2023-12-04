//
//  AddMovieViewModel.swift
//  MovieCave
//
//  Created by Admin on 27.09.23.
//

import Foundation
import Combine

//MARK: - TVSeriesViewModelProtocol
protocol TVSeriesViewModelProtocol {
    func filterSeries(_ genre: String)
    func changePage(nextPage: Bool)
    func searchTVSeries(with query: String)
    func sendSeriesDetails(with movieID: Int)
    func restoreListAfterSearch()
    var series: CurrentValueSubject<[TVSeriesResults]?, Never> { get }
    var popUpMessage: CurrentValueSubject<String?, Never> { get }
}

class TVSeriesViewModel: TVSeriesViewModelProtocol {

    //MARK: - Properties
    private weak var coordinator: TVSeriesViewCoordinator?
    private let movieDBService: MovieDBServiceProtocol
    private var currentPage: Int
    private var list: TVSeriesLists
    var series: CurrentValueSubject<[TVSeriesResults]?, Never> = CurrentValueSubject(nil)
    var popUpMessage: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
    
    //MARK: - Initializer
    init(coordinator: TVSeriesViewCoordinator, movieDBService: MovieDBServiceProtocol, currentPage: Int, list: TVSeriesLists) {
        self.coordinator = coordinator
        self.movieDBService = movieDBService
        self.currentPage = currentPage
        self.list = list
        fetchSeries(withFilter: list, on: currentPage)
    }
    
    //MARK: - Methods
    func changePage(nextPage: Bool) {
        guard nextPage else { return }

        currentPage += 1
        fetchSeries(withFilter: list, on: currentPage)
    }

    func restoreListAfterSearch() {
        currentPage = 1
        fetchSeries(withFilter: list, on: currentPage)
    }
    
    func filterSeries(_ filter: String) {
        switch filter {
        case Constants.popularTVSeriesFilterButton:
            list = .popular
            fetchSeries(withFilter: .popular, on: currentPage)
        case Constants.airingTodayTVSeriesFilterButton:
            list = .airingToday
            fetchSeries(withFilter: .airingToday, on: currentPage)
        case Constants.topRatedTVSeriesFilterButton:
            list = .topRated
            fetchSeries(withFilter: .topRated, on: currentPage)
        case Constants.onTheAirTVSeriesFilterButton:
            list = .onTheAir
            fetchSeries(withFilter: .onTheAir, on: currentPage)
        default:
            break
        }
    }
    
    private func fetchSeries(withFilter: TVSeriesLists, on page: Int) {
        movieDBService.operateWithAPI(type: .tvSeries, key: withFilter.tvSeriesList(), page: page, operationType: .fetchSeries, httpMethod: .get) { [weak self] (result: Result<TVSeriesData, MovieDBErrors>) in
            guard let self else { return }
            
//            DispatchQueue.main.async {
                switch result {
                case .success(let series):
                    self.series.send(series.results)
                case .failure(let error):
                    self.popUpMessage.send(error.localizedDescription)
                }
//            }
        }
    }
    
    func searchTVSeries(with query: String) {
        movieDBService.operateWithAPI(type: .tvSeries, key: query, page: currentPage, operationType: .searchSeriesByTitle, httpMethod: .get) { [weak self]
            (result: Result<TVSeriesData, MovieDBErrors>) in
            guard let self else { return }
            
//            DispatchQueue.main.async {
                switch result {
                case .success(let series):
                    self.series.send(series.results)
                case .failure(let error):
                    self.popUpMessage.send(error.localizedDescription)
                }
//            }
        }
    }

    func sendSeriesDetails(with seriesID: Int) {
        coordinator?.loadSeriesDetailsView(with: seriesID)
    }

}
