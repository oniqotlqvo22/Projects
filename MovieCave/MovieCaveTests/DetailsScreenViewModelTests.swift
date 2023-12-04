//
//  DetailsScreenViewModelTests.swift
//  MovieCaveTests
//
//  Created by Admin on 1.12.23.
//

import XCTest
@testable import MovieCave

final class DetailsScreenViewModelTests: XCTestCase {
    
    var mockMovieDBService: MovieDBManagerMock!
    var movieDetailsCoordinator: MovieDetailsViewCoordinator!
    var tvSeriesDetailsCoordinator: TVSeriesDetailsCoordinator!
    var viewModel: DetailsScreenViewModel!
    let navController = UINavigationController()
    
    override func setUp() {
        super.setUp()
        mockMovieDBService = MovieDBManagerMock(succesCase: .happy, moviesList: .allMovies)
    }
    
    override func tearDown() {
        super.tearDown()
        mockMovieDBService = nil
        movieDetailsCoordinator = nil
        tvSeriesDetailsCoordinator = nil
        viewModel = nil
    }
    
    func test_DetailsView_withTVSeries_HappyCase() {
        // Given
        let id = 10
        movieDetailsCoordinator = MovieDetailsViewCoordinator(navController: navController, id: id)
        viewModel = DetailsScreenViewModel(mediaType: .tvSeries, id: id, coordinator: movieDetailsCoordinator, apiService: mockMovieDBService)
        
        // When
        
        
        // Then
        XCTAssertEqual(viewModel.mediaDetails.value, mockMovieDBService.mediaDetails)
        XCTAssertEqual(viewModel.mediaVideos.value?.last, mockMovieDBService.mediaVideos)
        XCTAssertEqual(viewModel.mediaCast.value?.last, mockMovieDBService.mediaCast)
        XCTAssertNil(mockMovieDBService.apiCallError)
        XCTAssertNotNil(mockMovieDBService.apiCallTVSeriesResult?.results)
        XCTAssertNotNil(viewModel.mediaCast.value)
        XCTAssertNotNil(viewModel.mediaVideos.value)
        XCTAssertNotNil(viewModel.mediaDetails.value)
    }
    
    func test_DetailsView_withTVSeries_SadCase() {
        // Given
        let id = 10
        movieDetailsCoordinator = MovieDetailsViewCoordinator(navController: navController, id: id)
        mockMovieDBService.succesCase = .sad
        viewModel = DetailsScreenViewModel(mediaType: .tvSeries, id: id, coordinator: movieDetailsCoordinator, apiService: mockMovieDBService)
        
        // When
        
        
        // Then
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(viewModel.popUpMessage)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
        XCTAssertNil(viewModel.mediaCast.value)
        XCTAssertNil(viewModel.mediaVideos.value)
        XCTAssertNil(viewModel.mediaDetails.value)
    }
    
    func test_DetailsView_withMovies_HappyCase() {
        // Given
        let id = 10
        movieDetailsCoordinator = MovieDetailsViewCoordinator(navController: navController, id: id)
        viewModel = DetailsScreenViewModel(mediaType: .movies, id: id, coordinator: movieDetailsCoordinator, apiService: mockMovieDBService)
        
        // When
        
        
        // Then
        XCTAssertEqual(viewModel.mediaDetails.value, mockMovieDBService.mediaDetails)
        XCTAssertEqual(viewModel.mediaVideos.value?.last, mockMovieDBService.mediaVideos)
        XCTAssertEqual(viewModel.mediaCast.value?.last, mockMovieDBService.mediaCast)
        XCTAssertNil(mockMovieDBService.apiCallError)
        XCTAssertNotNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
        XCTAssertNotNil(viewModel.mediaCast.value)
        XCTAssertNotNil(viewModel.mediaVideos.value)
        XCTAssertNotNil(viewModel.mediaDetails.value)
    }
    
    func test_DetailsView_withMovies_SadCase() {
        // Given
        let id = 10
        movieDetailsCoordinator = MovieDetailsViewCoordinator(navController: navController, id: id)
        mockMovieDBService.succesCase = .sad
        viewModel = DetailsScreenViewModel(mediaType: .movies, id: id, coordinator: movieDetailsCoordinator, apiService: mockMovieDBService)
        
        // When
        
        
        // Then
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(viewModel.popUpMessage)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertNil(mockMovieDBService.apiCallMoviesResult?.movieResults)
        XCTAssertNil(viewModel.mediaCast.value)
        XCTAssertNil(viewModel.mediaVideos.value)
        XCTAssertNil(viewModel.mediaDetails.value)
    }
}
