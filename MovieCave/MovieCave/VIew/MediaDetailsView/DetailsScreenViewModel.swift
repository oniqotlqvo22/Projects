//
//  MovieDetailsScreenViewModel.swift
//  MovieCave
//
//  Created by Admin on 2.10.23.
//

import Foundation
import Combine

//MARK: - DetailsScreenViewModelProtocol
protocol DetailsScreenViewModelProtocol {
    var mediaVideos: CurrentValueSubject<[MediaVideos]?, Never> { get }
    var mediaCast: CurrentValueSubject<[MediaCast]?, Never> { get }
    var mediaDetails: CurrentValueSubject<MediaDetails?, Never> { get }
    var popUpMessage: CurrentValueSubject<String?, Never> { get }
}

protocol DetailsScreenCoordinatorProtocol: AnyObject {

}

class DetailsScreenViewModel: DetailsScreenViewModelProtocol {
    
    //MARK: - Properties
    var mediaDetails: CurrentValueSubject<MediaDetails?, Never> = CurrentValueSubject(nil)
    var mediaVideos: CurrentValueSubject<[MediaVideos]?, Never> = CurrentValueSubject(nil)
    var mediaCast: CurrentValueSubject<[MediaCast]?, Never> = CurrentValueSubject(nil)
    var popUpMessage: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
    weak var coordinator: DetailsScreenCoordinatorProtocol?
    private var apiService: MovieDBServiceProtocol
    
    //MARK: - Initializer
    init(mediaType: MediaType ,id: Int, coordinator: DetailsScreenCoordinatorProtocol, apiService: MovieDBServiceProtocol) {
        self.coordinator = coordinator
        self.apiService = apiService
        switch mediaType {
        case .tvSeries:
            fetcSeriesDetails(mediaType: mediaType, with: "\(id)")
            fetchSeriesVideos(mediaType: mediaType, with: id)
            fetchSeriesCast(mediaType: mediaType, with: id)
        case .movies:
            fetchMovieDetails(mediaType: mediaType, with: "\(id)")
            fetchMovieVideos(mediaType: mediaType, with: id)
            fetchMovieCast(mediaType: mediaType, with: id)
        }
    }
    
    //MARK: - Methods
    private func fetcSeriesDetails(mediaType: MediaType, with key: String) {
        apiService.operateWithAPI(type: mediaType, key: "\(key)", page: 1, operationType: .fetchSeriesDetails, httpMethod: .get) { [weak self] (result: Result<TVSeriesDetailsData, MovieDBErrors>) in
            
            switch result {
            case .success(let series):
                let seriesDetails = MediaDetails(title: series.name,
                                                overview: series.overview,
                                                id: series.id,
                                                 poster: series.posterPath ?? Constants.noImageString,
                                                 bigPoster: series.backdropPath ?? Constants.noImageString,
                                                avrgVote: "\(series.voteAverage.roundedToTwoDecimalPlaces())",
                                                releaseDate: series.firstAirDate,
                                                gernes: series.genres.map{$0.name})
                    self?.mediaDetails.send(seriesDetails)
            case .failure(let error):
                self?.popUpMessage.send(error.localizedDescription)
            }
        }
    }
    
    private func fetchSeriesCast(mediaType: MediaType, with ID: Int) {
        apiService.operateWithAPI(type: mediaType, key: "\(ID)", page: 1, operationType: .fetchSeriesCast, httpMethod: .get) { [weak self] (result: Result<TVSeriesCastData, MovieDBErrors>) in
            
            switch result {
            case .success(let cast):
                var castArray = [MediaCast]()
                cast.cast.forEach {
                    let cast = MediaCast(name: $0.name, poster: $0.profilePath)
                    castArray.append(cast)
                }
                
                self?.mediaCast.send(castArray)
            case .failure(let error):
                self?.popUpMessage.send(error.localizedDescription)
            }
        }
    }
    
    private func fetchSeriesVideos(mediaType: MediaType, with ID: Int) {
        apiService.operateWithAPI(type: mediaType, key: "\(ID)", page: 1, operationType: .fetchSeriesVideos, httpMethod: .get) { [weak self] (result: Result<TVSeriesVideosData, MovieDBErrors>) in
            
            switch result {
            case .success(let videos):
                var trailers = [MediaVideos]()
                videos.results.forEach { trailer in
                    guard trailer.type == Constants.trailerKeyWord else { return }
                    let video = MediaVideos(key: trailer.key, name: trailer.name)
                        trailers.append(video)
                }

                self?.mediaVideos.send(trailers)
            case .failure(let error):
                self?.popUpMessage.send(error.localizedDescription)
            }
        }
    }
    
    private func fetchMovieDetails(mediaType: MediaType, with key: String) {
        apiService.operateWithAPI(type: mediaType, key: "\(key)", page: 1, operationType: .fetchMovieDetails, httpMethod: .get) { [weak self] (result: Result<MovieDetailsData, MovieDBErrors>) in

            switch result {
            case .success(let series):
                let seriesDetails = MediaDetails(title: series.originalTitle,
                                                overview: series.overview,
                                                id: series.id,
                                                 poster: series.posterPath ?? Constants.noImageString,
                                                bigPoster: series.backdropPath ?? Constants.noImageString,
                                                avrgVote: "\(series.voteAverage.roundedToTwoDecimalPlaces())",
                                                releaseDate: series.releaseDate,
                                                gernes: series.genres.map{$0.name})
                    self?.mediaDetails.send(seriesDetails)
            case .failure(let error):
                self?.popUpMessage.send(error.localizedDescription)
            }
        }
    }

    private func fetchMovieCast(mediaType: MediaType, with ID: Int) {
        apiService.operateWithAPI(type: mediaType, key: "\(ID)", page: 1, operationType: .fetchMovieCast, httpMethod: .get) { [weak self] (result: Result<MovieCast, MovieDBErrors>) in
            
            switch result {
            case .success(let cast):
                var castArray = [MediaCast]()
                cast.cast.forEach {
                    let cast = MediaCast(name: $0.name, poster: $0.profilePath)
                    castArray.append(cast)
                }

                self?.mediaCast.send(castArray)
            case .failure(let error):
                self?.popUpMessage.send(error.localizedDescription)
            }
        }
    }

    private func fetchMovieVideos(mediaType: MediaType, with ID: Int) {
        apiService.operateWithAPI(type: mediaType, key: "\(ID)", page: 1, operationType: .fetchMovieVideos, httpMethod: .get) { [weak self] (result: Result<MovieVideos, MovieDBErrors>) in
            
            switch result {
            case .success(let videos):
                var trailers = [MediaVideos]()
                videos.results.forEach { trailer in
                    guard trailer.type == Constants.trailerKeyWord else { return }
                    let video = MediaVideos(key: trailer.key, name: trailer.name)
                        trailers.append(video)
                }

                self?.mediaVideos.send(trailers)

            case .failure(let error):
                self?.popUpMessage.send(error.localizedDescription)
            }
        }
    }
    
}
