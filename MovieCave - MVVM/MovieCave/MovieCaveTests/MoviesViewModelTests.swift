//
//  MoviesViewModelTests.swift
//  MovieCaveTests
//
//  Created by Admin on 22.11.23.
//

import XCTest
@testable import MovieCave

final class MoviesViewModelTests: XCTestCase {

    var mockMovieDBService: MovieDBManagerMock!
    var mockCoordinator: MockCoordinator!
    var viewModel: MoviesViewModelProtocol!
    var currentPage = 1
    var genreList: MovieGenreLists = .topRated
    var list: MoviesList!
    
    override func setUp() {
        super.setUp()
        mockMovieDBService = MovieDBManagerMock(succesCase: .sad, moviesList: .allMovies)
        mockCoordinator = MockCoordinator(successType: .happy)
        viewModel = MoviesViewModel(moviesViewCoordinatorDelegate: mockCoordinator,
                                    movieDBService: mockMovieDBService,
                                    dataSource: CollectionViewDataSource(items: []),
                                    with: .allMovies,
                                    with: .popular,
                                    currentPage: 1)
    }

    override func tearDown() {
        super.tearDown()
        mockMovieDBService = nil
        mockCoordinator = nil
        viewModel = nil
    }
    
    func test_favoriteButtonClicked_HappyCase_withFavorite() {
        // Given
        mockMovieDBService.succesCase = .happy
        viewModel.dataSource.items = [MoviesModel(movieResults: MovieResults(id: 10,
                                                                             originalTitle: "TITLE",
                                                                             overview: "OVERVIEW",
                                                                             genreIds: [1]),
                                                                             isFavorite: true)]
        
        // When
        viewModel.buttonClicked(index: 0)
        
        // Then
        
        XCTAssertEqual(10, mockMovieDBService.apiCallMoviesResult?.movieResults.id)
    }
    
    func test_favoriteButtonClicked_HappyCase_withNotFavorite() {
        // Given
        mockMovieDBService.succesCase = .happy
        viewModel.dataSource.items = [MoviesModel(movieResults: MovieResults(id: 10,
                                                                             originalTitle: "TITLE",
                                                                             overview: "OVERVIEW",
                                                                             genreIds: [1]),
                                                                             isFavorite: false)]
        
        // When
        viewModel.buttonClicked(index: 0)
        
        // Then
        
        XCTAssertEqual(10, mockMovieDBService.apiCallMoviesResult?.movieResults.id)
    }
    
    func test_favoriteButtonClicked_SadCase() {
        // Given
        viewModel.dataSource.items = [MoviesModel(movieResults: MovieResults(id: 10,
                                                                             originalTitle: "TITLE",
                                                                             overview: "OVERVIEW",
                                                                             genreIds: [1]),
                                                                             isFavorite: false)]
        
        // When
        viewModel.buttonClicked(index: 0)
        
        // Then
        
        XCTAssertNil(mockMovieDBService.apiCallMoviesResult?.movieResults.id)
    }
    
    func test_sendMovieDetails_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        viewModel = MoviesViewModel(moviesViewCoordinatorDelegate: mockCoordinator,
                                    movieDBService: mockMovieDBService,
                                    dataSource: CollectionViewDataSource(items: []),
                                    with: .allMovies,
                                    with: genreList,
                                    currentPage: 1)
        
        // When
        viewModel.sendMovieDetails(with: 10)
        
        // Then
        XCTAssertEqual(10, mockMovieDBService.apiCallMoviesResult?.movieResults.id)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
        XCTAssertEqual(10, mockCoordinator.mediaID)
        XCTAssertNotNil(mockCoordinator.mediaID)
    }
    
    func test_sendMoviesDetails_SadCase() {
        // Given
        mockCoordinator.successType = .sad
        
        // When
        viewModel.sendMovieDetails(with: 10)
        
        // Then
        XCTAssertNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertNotEqual(10, mockCoordinator.mediaID)
        XCTAssertNil(mockCoordinator.mediaID)
    }
    
    func test_favoriteMovieListOperations_HappyCase_withAddFavorite() {
        // Given
        let expectedTItle = "key"
        mockMovieDBService.succesCase = .happy
        
        // When
        viewModel.favoriteMovieListOperations(with: 10, for: .addToFavorites)
        
        // Then
        XCTAssertEqual(mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle, expectedTItle)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
    }
    
    func test_favoriteMovieListOperations_HappyCase_withRemoveFavorite() {
        // Given
        let expectedTItle = "key"
        mockMovieDBService.succesCase = .happy
        
        // When
        viewModel.favoriteMovieListOperations(with: 10, for: .removeFromFavorites)
        
        // Then
        XCTAssertEqual(mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle, expectedTItle)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
    }
    
    func test_favoriteMovieListOperations_SadCase() {
        // Given
        
        // When
        viewModel.favoriteMovieListOperations(with: 10, for: .addToFavorites)
        
        // Then
        XCTAssertNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
    }

    func test_filterMovies_HappyCase() {
        // Given
        mockMovieDBService = MovieDBManagerMock(succesCase: .happy, moviesList: .allMovies)
        viewModel = MoviesViewModel(moviesViewCoordinatorDelegate: mockCoordinator,
                                    movieDBService: mockMovieDBService,
                                    dataSource: CollectionViewDataSource(items: []),
                                    with: .allMovies,
                                    with: genreList,
                                    currentPage: 1)
        
        let filter = [Constants.mostPopularFilterButton,
                      Constants.upComingFilterButton,
                      Constants.ratingFilterButton,
                      Constants.newestFilterButton]
        
        // When
        filter.forEach {viewModel.filterMovies($0)}
    
        // Then
        XCTAssertEqual(filter.last, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
        XCTAssertNil(mockMovieDBService.apiCallError)
        XCTAssertNil(viewModel.popUpMessage.value)
    }

    func test_filterMovies_SadCase() {
        // Given
        let filter = "Sad case"
        
        // When
        viewModel.filterMovies(filter)
        
        // Then
        XCTAssertNotEqual(filter, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertNotNil(viewModel.popUpMessage.value)
    }

    func test_performSearch_favorites_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        mockMovieDBService.moviesList = .favorites
        viewModel = MoviesViewModel(moviesViewCoordinatorDelegate: mockCoordinator,
                                    movieDBService: mockMovieDBService,
                                    dataSource: CollectionViewDataSource(items: []),
                                    with: .favorites,
                                    with: genreList,
                                    currentPage: 1)
        let searchText = "Happy case"
        
        // When
        viewModel.performSearch(with: searchText)
        
        // Then
        XCTAssertEqual(viewModel.dataSource.items.last?.movieResults.originalTitle, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult)
        XCTAssertEqual(searchText, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }
    
    func test_performSearch_allMovies_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        let searchText = "Happy case"
        
        // When
        viewModel.performSearch(with: searchText)
        
        // Then
        XCTAssertEqual(viewModel.dataSource.items.last?.movieResults.originalTitle, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult)
        XCTAssertEqual(searchText, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }
    
    func test_performSearch_SadCase() {
        // Given
        
        let searchText = ""
        
        // When
        viewModel.performSearch(with: searchText)
        
        // Then
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }

}
