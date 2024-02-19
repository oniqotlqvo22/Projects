//
//  TvSeriesDetailsViewModelTests.swift
//  MovieCaveTests
//
//  Created by Admin on 1.02.24.
//

import XCTest
@testable import MovieCave

final class TvSeriesDetailsViewModelTests: XCTestCase {
    
    var mockMovieDBService: MovieDBManagerMock!
    var tvSeriesDetailsCoordinatorDelegate: TVSeriesDetailsCoordinator!
    var viewModel: TvSeriesDetailsViewModel!
    let navController = UINavigationController()
    
    override func setUp() {
        super.setUp()
        mockMovieDBService = MovieDBManagerMock(succesCase: .happy, moviesList: .allMovies)
    }
    
    override func tearDown() {
        super.tearDown()
        mockMovieDBService = nil
        tvSeriesDetailsCoordinatorDelegate = nil
        viewModel = nil
    }
    
    func test_DetailsView_withTVSeries_HappyCase() {
        // Given
        let id = 10
        tvSeriesDetailsCoordinatorDelegate = TVSeriesDetailsCoordinator(navController: navController, seriesID: id)
        viewModel = TvSeriesDetailsViewModel(mediaID: id, tvSeriesDetailsCoordinatorDelegate: tvSeriesDetailsCoordinatorDelegate, apiService: mockMovieDBService, with: .tvSeries)
        
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
        tvSeriesDetailsCoordinatorDelegate = TVSeriesDetailsCoordinator(navController: navController, seriesID: id)
        mockMovieDBService.succesCase = .sad
        viewModel = TvSeriesDetailsViewModel(mediaID: id, tvSeriesDetailsCoordinatorDelegate: tvSeriesDetailsCoordinatorDelegate, apiService: mockMovieDBService, with: .tvSeries)
        
        // When
        
        
        // Then
        XCTAssertEqual(viewModel.popUpMessage.value, mockMovieDBService.apiCallError)
        XCTAssertNotNil(viewModel.popUpMessage)
        XCTAssertNotNil(mockMovieDBService.apiCallError)
        XCTAssertNil(mockMovieDBService.apiCallTVSeriesResult?.results)
        XCTAssertNil(viewModel.mediaCast.value)
        XCTAssertNil(viewModel.mediaVideos.value)
        XCTAssertNil(viewModel.mediaDetails.value)
    }
    
}
