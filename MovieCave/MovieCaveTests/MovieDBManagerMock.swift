//
//  MovieDBManagerMock.swift
//  MovieCaveTests
//
//  Created by Admin on 16.11.23.
//

import Foundation
@testable import MovieCave

enum MockMovieDBManagerType {
    case happy
    case sad
}

class MovieDBManagerMock: MovieDBServiceProtocol {
    
    var succesCase: MockMovieDBManagerType
    var operateWithAPIType: MediaType?
    var moviesList: MoviesList
    var operateWithAPIKey: String?
    var operateWithAPIPage: Int?
    var operateWithAPIOperationType: APIOperations?
    var operateWithAPIHTTPMethod: HTTPMethod?
    
    var apiCallTVSeriesResult: TVSeriesData?
    var apiCallMoviesResult: MoviesModel?
    var apiCallError: String?
    var mediaDetails: MediaDetails?
    var mediaVideos: MediaVideos?
    var mediaCast: MediaCast?
    
    var fetchRequestTokenCalled = false
     
    init(succesCase: MockMovieDBManagerType, moviesList: MoviesList) {
        self.succesCase = succesCase
        self.moviesList = moviesList
    }
    
    func operateWithAPI<R: Codable>(type: MediaType, key: String, page: Int, operationType: APIOperations, httpMethod: HTTPMethod, completion: @escaping (Result<R, MovieDBErrors>) -> Void) {

        operateWithAPIType = type
        operateWithAPIPage = page
        operateWithAPIOperationType = operationType
        operateWithAPIHTTPMethod = httpMethod
        
        switch type {
        case .tvSeries:
            if R.self == TVSeriesData.self {
                mockTVSeriesAPICall(page: page, key: key, completion: completion)
            } else if R.self == TVSeriesDetailsData.self {
                mockTVSeriesAPICall(page: page, key: key, completion: completion)
            } else if R.self == TVSeriesCastData.self {
                mockTVSeriesAPICall(page: page, key: key, completion: completion)
            } else if R.self == TVSeriesVideosData.self {
                mockTVSeriesAPICall(page: page, key: key, completion: completion)
            }
        case .movies:
            if R.self == MoviesData.self {
                mockMoviesAPICall(page: page, key: key, completion: completion)
            } else if R.self == MovieDetailsData.self {
                mockMoviesAPICall(page: page, key: key, completion: completion)
            } else if R.self == MovieCast.self {
                mockMoviesAPICall(page: page, key: key, completion: completion)
            } else if R.self == MovieVideos.self {
                mockMoviesAPICall(page: page, key: key, completion: completion)
            }
        }

    }
    
    private func mockMoviesAPICall<R: Codable>(page: Int, key: String, completion: @escaping (Result<R, MovieDBErrors>) -> Void) {
        guard page == 1 else {
            operateWithAPIPage = page
            completion(.failure(.badData))
             return
        }
        
        let results = [MovieResults(id: 10,
                                    originalTitle: key,
                                    overview: "COLD",
                                    genreIds: [1],
                                    posterPath: "POSTER")]
        
        
        let movies = MoviesData(page: page, results: results)
        
        switch succesCase {
        case .sad:
            operateWithAPIKey = key
            let error = MovieDBErrors.badData.localizedDescription
            completion(.failure(.badData))
            apiCallError = error
        case .happy:
            switch key {
            case "\(10)":
                operateWithAPIKey = key
                createMovieArray(moviesFromApi: movies.results) { [weak self] model in
                    self?.apiCallMoviesResult = model.last
                }
                
                if R.self == MovieDetailsData.self {
                    let details: MovieDetailsData = MovieDetailsData(genres: [],
                                                                     id: 10,
                                                                     releaseDate: "10.10",
                                                                     runtime: 20,
                                                                     voteAverage: 8,
                                                                     voteCount: 50,
                                                                     backdropPath: "BACK POSTER",
                                                                     posterPath: "BIG POSTER",
                                                                     originalTitle: "TITLE",
                                                                     overview: "OVERVIEW")
                    mediaDetails = MediaDetails(title: details.originalTitle,
                                                overview: details.overview,
                                                id: details.id,
                                                poster: details.posterPath ?? "POSTER",
                                                bigPoster: details.backdropPath ?? "POSTTER",
                                                avrgVote: "\(details.voteAverage)",
                                                releaseDate: details.releaseDate,
                                                gernes: details.genres.map{$0.name})
                    completion(.success(details as! R))
                } else if R.self == MovieVideos.self {
                    let videos: MovieVideos = MovieVideos(results: [MovieVideos.VideoResults(name: "MOVIE", key: "KEY", site: "MYSITE", type: "Trailer", id: "\(15)")])
                    mediaVideos = MediaVideos(key: videos.results[0].key, name: videos.results[0].name)
                    completion(.success(videos as! R))
                } else if R.self == MovieCast.self {
                    let cast: MovieCast = MovieCast(cast: [MovieCast.CastDetails(name: "JOHN")])
                    mediaCast = MediaCast(name: cast.cast[0].name)
                    completion(.success(cast as! R))
                }
                
            case "popular":
                operateWithAPIKey = "Most popular"
                createMovieArray(moviesFromApi: movies.results) { [weak self] model in
                    self?.apiCallMoviesResult = model.last
                }
                completion(.success(movies as! R))
            case "upcoming":
                operateWithAPIKey = "Upcoming"
                createMovieArray(moviesFromApi: movies.results) { [weak self] model in
                    self?.apiCallMoviesResult = model.last
                }
                completion(.success(movies as! R))
            case "top_rated":
                operateWithAPIKey = "Top rated"
                createMovieArray(moviesFromApi: movies.results) { [weak self] model in
                    self?.apiCallMoviesResult = model.last
                }
                completion(.success(movies as! R))
            case "now_playing":
                operateWithAPIKey = "Newest"
                createMovieArray(moviesFromApi: movies.results) { [weak self] model in
                    self?.apiCallMoviesResult = model.last
                }
                completion(.success(movies as! R))
            default:
                operateWithAPIKey = key
                createMovieArray(moviesFromApi: movies.results) { [weak self] model in
                    self?.apiCallMoviesResult = model.last
                }
                completion(.success(movies as! R))
            }
        }
    }
    
    private func mockTVSeriesAPICall<R: Codable>(page: Int, key: String, completion: @escaping (Result<R, MovieDBErrors>) -> Void) {
        guard page == 1 else {
            operateWithAPIPage = page
            completion(.failure(.badData))
             return
        }
        
        let results = [TVSeriesResults(id: 10,
                                      name: key,
                                      overview: "HOT",
                                       genreIds: [1])]
        let data = TVSeriesData(page: page, results: results)
        
        switch succesCase {
        case .sad:
            operateWithAPIKey = key
            let error = MovieDBErrors.badData.localizedDescription
            completion(.failure(.badData))
            apiCallError = error
        case .happy:
            switch key {
            case "\(10)":
                operateWithAPIKey = key
                apiCallTVSeriesResult = data
                if R.self == TVSeriesDetailsData.self {
                    let details: TVSeriesDetailsData = TVSeriesDetailsData(genres: [],
                                                                           id: 25,
                                                                           firstAirDate: "25.10",
                                                                           name: "SERIES NAME",
                                                                           backdropPath: "BACK POSTER",
                                                                           posterPath: "POSTER BIG",
                                                                           voteAverage: 9,
                                                                           voteCount: 59,
                                                                           overview: "OOOVER")
                    mediaDetails = MediaDetails(title: details.name,
                                                overview: details.overview,
                                                id: details.id,
                                                poster: details.posterPath ?? "POSTER",
                                                bigPoster: details.backdropPath ?? "POSTTER",
                                                avrgVote: "\(details.voteAverage)",
                                                releaseDate: details.firstAirDate,
                                                gernes: details.genres.map{$0.name})
                    completion(.success(details as! R))
                } else if R.self == TVSeriesVideosData.self {
                    let videos: TVSeriesVideosData = TVSeriesVideosData(results: [TVSeriesVideosData.VideoResults(name: "VIDEO", key: "VIDEO", site: "MY", type: "Trailer", id: "\(22)")])
                    mediaVideos = MediaVideos(key: videos.results[0].key, name: videos.results[0].name)
                    completion(.success(videos as! R))
                } else if R.self == TVSeriesCastData.self {
                    let cast: TVSeriesCastData = TVSeriesCastData(cast: [TVSeriesCastData.CastDetails(name: "CASTER")])
                    mediaCast = MediaCast(name: cast.cast[0].name)
                    completion(.success(cast as! R))
                }
            case "popular":
                operateWithAPIKey = "Most popular"
                apiCallTVSeriesResult = data
                completion(.success(data as! R))
            case "airing_today":
                operateWithAPIKey = "Airing today"
                completion(.success(data as! R))
            case "top_rated":
                operateWithAPIKey = "Top rated"
                completion(.success(data as! R))
            case "on_the_air":
                operateWithAPIKey = "On the air"
                completion(.success(data as! R))
            default:
                operateWithAPIKey = key
                completion(.success(data as! R))
                apiCallTVSeriesResult = data
            }
        }
    }
    
    func createMovieArray(moviesFromApi: [MovieResults], completion: @escaping ([MoviesModel]) -> Void) {
        var movieWrappers = [MoviesModel]()
        
        switch moviesList {
        case .allMovies:
            moviesFromApi.forEach { result in
                let movie = MoviesModel(movieResults: result, isFavorite: false)
                movieWrappers.append(movie)
            }
            completion(movieWrappers)
        case .favorites:
            fetchFavoriteMovies(moviesFromApi: moviesFromApi) { completion($0) }
        }
        
    }
    
    func fetchFavoriteMovies(moviesFromApi: [MovieResults], completion: @escaping ([MoviesModel]) -> Void) {
        var favoriteMovies = [MoviesModel]()
        
        moviesFromApi.forEach { results in
            var favoriteMovie = MoviesModel(movieResults: results, isFavorite: false)
            favoriteMovie.isFavorite = true
            favoriteMovies.append(favoriteMovie)
        }
        completion(favoriteMovies)
    }
    
    func menageFavoritesMovies(with movieID: Int, for operation: Favorites) {
        let results = [MovieResults(id: 10,
                                     originalTitle: "key",
                                     overview: "COLD",
                                     genreIds: [1])]
        
        switch succesCase {
        case .happy:
            guard let movie = results.first(where: { $0.id == movieID }) else { return }
    
            let movieModel: MoviesModel = MoviesModel(movieResults: movie, isFavorite: true)
            apiCallMoviesResult = movieModel
        case .sad:
            apiCallMoviesResult = nil
        }
    }
    
    func fetchRequestToken() {
        switch succesCase {
        case .happy:
            fetchRequestTokenCalled = true
        case .sad:
            fetchRequestTokenCalled = false
        }
    }
    
}
