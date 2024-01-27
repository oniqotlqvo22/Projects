//
//  TVSeriesViewModelTests.swift
//  MovieCaveTests
//
//  Created by Admin on 16.11.23.
//

import XCTest
//import Combine
@testable import MovieCave

final class MovieCaveTests: XCTestCase {

    var mockMovieDBService: MovieDBManagerMock!
    var viewModel: TVSeriesViewModel!
    var currentPage = 1
    
    override func setUp() {
        super.setUp()
        mockMovieDBService = MovieDBManagerMock(succesCase: .happy, moviesList: .allMovies)
        viewModel = TVSeriesViewModel(coordinator: TVSeriesViewCoordinator(navController: UINavigationController()), movieDBService: mockMovieDBService, currentPage: currentPage, list: .popular)
    }

    override func tearDown() {
        super.tearDown()
        mockMovieDBService = nil
        viewModel = nil
    }
    
    func test_sendSeriesDetails_HappyCase() {
        // Given
        let id = 10
        
        // When
        viewModel.sendSeriesDetails(with: id)
        
        // Then
        XCTAssertEqual(id, mockMovieDBService.apiCallTVSeriesResult?.results[0].id)
        XCTAssertNotNil(mockMovieDBService.apiCallTVSeriesResult?.results[0].id)
        XCTAssertEqual(viewModel.series.value?.last?.id, id)
    }
    
    func test_sendSeriesDetails_SadCase() {
        // Given
        let id = 12
        mockMovieDBService.succesCase = .sad
        
        // When
        viewModel.sendSeriesDetails(with: id)
        
        // Then
        XCTAssertNotEqual(id, mockMovieDBService.apiCallTVSeriesResult?.results[0].id)
        XCTAssertNotNil(mockMovieDBService.apiCallTVSeriesResult?.results[0].id)
        XCTAssertNotEqual(viewModel.series.value?.last?.id, id)
    }
    
    func test_searchTVSeries_HappyCase() {
        // Given
        let searchText = "Happy case"
        
        // When
        viewModel.searchTVSeries(with: searchText)
        
        // Then
        XCTAssertEqual(viewModel.series.value?.last?.name, mockMovieDBService.apiCallTVSeriesResult?.results.last?.name)
        XCTAssertNotNil(mockMovieDBService.apiCallTVSeriesResult)
        XCTAssertEqual(searchText, mockMovieDBService.apiCallTVSeriesResult?.results[0].name)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }
    
    func test_searchTVSeries_SadCase() {
        // Given
        mockMovieDBService.succesCase = .sad
        let searchText = "Sad case"
        
        // When
        viewModel.searchTVSeries(with: searchText)
        
        // Then
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertEqual(searchText, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
    }
    
    func test_filterSeries_HappyCase() {
        // Given
        let filter = [Constants.popularTVSeriesFilterButton,
                      Constants.airingTodayTVSeriesFilterButton,
                      Constants.onTheAirTVSeriesFilterButton,
                      Constants.topRatedTVSeriesFilterButton]
        
        // When
        filter.forEach {viewModel.filterSeries($0)}
        
        // Then
        XCTAssertEqual(filter.last, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(viewModel.series.value)
    }

    func test_filterSeries_SadCase() {
        // Given
        let filter = "Sad case"
        
        // When
        viewModel.filterSeries(filter)
        
        // Then
        XCTAssertNotEqual(filter, mockMovieDBService.operateWithAPIKey)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIKey)
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
    }
    
    func test_restoreListAfterSearch_HappyCase() {
        // Given
        
        // When
        viewModel.resetToFirstPage()
        
        // Then
        XCTAssertEqual(currentPage, mockMovieDBService.operateWithAPIPage)
        XCTAssertNotNil(mockMovieDBService.operateWithAPIPage)
        XCTAssertEqual(viewModel.series.value?.last?.name, mockMovieDBService.apiCallTVSeriesResult?.results.last?.name)
    }
    
    func test_restoreListAfterSearch_SadCase() {
        // Given
        currentPage = 2
        
        // When
        viewModel.resetToFirstPage()
        
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
    
    
}
