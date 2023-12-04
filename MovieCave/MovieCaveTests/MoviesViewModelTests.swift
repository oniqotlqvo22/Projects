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
    var coordinator: MoviesViewCoordinator!
    var viewModel: MoviesViewModel!
    var currentPage = 1
    var genreList: MovieGenreLists = .topRated
    var list: MoviesList!
    
    override func setUp() {
        super.setUp()
        mockMovieDBService = MovieDBManagerMock(succesCase: .sad, moviesList: .allMovies)
        coordinator = MoviesViewCoordinator(navController: UINavigationController(), with: mockMovieDBService.moviesList)
        viewModel = MoviesViewModel(coordinator: coordinator,
                                    movieDBService: mockMovieDBService,
                                    with: mockMovieDBService.moviesList,
                                    with: genreList)
    }

    override func tearDown() {
        super.tearDown()
        mockMovieDBService = nil
        coordinator = nil
        viewModel = nil
    }
    
    func test_sendMovieDetails_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        viewModel = MoviesViewModel(coordinator: coordinator, movieDBService: mockMovieDBService, with: .allMovies, with: genreList)
        
        // When
        viewModel.sendMovieDetails(with: 10)
        
        // Then
        XCTAssertEqual(10, mockMovieDBService.apiCallMoviesResult?.movieResults.id)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
    }
    
    func test_sendMoviesDetails_SadCase() {
        // Given
        
        // When
        viewModel.sendMovieDetails(with: 10)
        
        // Then
        XCTAssertNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
    }
    
    func test_favoriteMovieListOperations_HappyCase() {
        // Given
        let expectedTItle = "key"
        mockMovieDBService.succesCase = .happy
        
        // When
        viewModel.favoriteMovieListOperations(with: 10, for: .addToFavorites)
        
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

    func test_filterSeries_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        let filter = [Constants.mostPopularFilterButton,
                      Constants.upComingFilterButton,
                      Constants.ratingFilterButton,
                      Constants.newestFilterButton]
        
        // When
        filter.forEach {viewModel.filterMovies($0)}
    
        // Then
        XCTAssertEqual(filter.last, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(viewModel.movies.value)
    }

    func test_filterSeries_SadCase() {
        // Given
        let filter = "Sad case"
        
        // When
        viewModel.filterMovies(filter)
        
        // Then
        XCTAssertNotEqual(filter, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
    }

    func test_restoreListAfterSearch_HappyCase() {
        // Given
        
        // When
        viewModel.restoreListAfterSearch()
        
        // Then
        XCTAssertEqual(currentPage, mockMovieDBService.operateWithAPIPage)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIPage)
        XCTAssertEqual(viewModel.movies.value?.last?.movieResults.originalTitle, mockMovieDBService.apiCallTVSeriesResult?.results.last?.name)
    }
    
    func test_restoreListAfterSearch_SadCase() {
        // Given
        currentPage = 2
        
        // When
        viewModel.restoreListAfterSearch()
        
        // Then
        XCTAssertNotEqual(currentPage, mockMovieDBService.operateWithAPIPage)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIPage)
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
    }
    
    func test_ChangePage_HappyCase() {
        // Given
        let nextPage = true
        let expectedPage = 2

        // When
        viewModel.changePage(nextPage: nextPage)
        
        // Then
        XCTAssertNotEqual(currentPage, mockMovieDBService.operateWithAPIPage)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIPage)
        XCTAssertEqual(expectedPage, mockMovieDBService.operateWithAPIPage)
    }
    
    func test_ChangePage_SadCase() {
        // Given
        let nextPage = false
        let expectedPage = 2

        // When
        viewModel.changePage(nextPage: nextPage)
        
        // Then
        XCTAssertEqual(currentPage, mockMovieDBService.operateWithAPIPage)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIPage)
        XCTAssertNotEqual(expectedPage, mockMovieDBService.operateWithAPIPage)
    }
    
    func test_searchTVSeries_favorites_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        mockMovieDBService.moviesList = .favorites
        viewModel = MoviesViewModel(coordinator: coordinator, movieDBService: mockMovieDBService, with: .favorites, with: .topRated)
        let searchText = "Happy case"
        
        // When
        viewModel.searchMovies(searchText)
        
        // Then
        XCTAssertEqual(viewModel.movies.value?.last?.movieResults.originalTitle, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult)
        XCTAssertEqual(searchText, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }
    
    func test_searchTVSeries_allMovies_HappyCase() {
        // Given
        mockMovieDBService.succesCase = .happy
        let searchText = "Happy case"
        
        // When
        viewModel.searchMovies(searchText)
        
        // Then
        XCTAssertEqual(viewModel.movies.value?.last?.movieResults.originalTitle, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult)
        XCTAssertEqual(searchText, mockMovieDBService.apiCallMoviesResult?.movieResults.originalTitle)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }
    
    func test_searchTVSeries_SadCase() {
        // Given
        let searchText = "Sad case"
        
        // When
        viewModel.searchMovies(searchText)
        
        // Then
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }

}
