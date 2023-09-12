//
//  AddMovieViewModel.swift
//  Movie-Cave
//
//  Created by Admin on 10.09.23.
//

import Foundation
import Combine

protocol AddMovieViewModelProtocol {
    
    /// The movie being added that is passed to the view
    var movie: CurrentValueSubject<MovieData?, Never> { get }
    
    /// Finishes adding the movie and saves it
    func addFinishedMovie()
    
    /// Handles toggling a checkbox value
    /// - Parameter checkBoxText: The text of the checkbox
    func checkBox(checkBoxText: String)
    
    /// Receives the star rating from the rating view
    /// - Parameter rating: The number of stars selected
    func starsRatingReceived(rating: Int)
    
    /// Receives the star rating from the rating view
    /// - Parameter title: The number of stars selected
    func receiveMovieTitle(title: String)
    
    /// Receives the title entered in the title field
    /// - Parameter description: The movie title text
    func receiveMovieDescrption(description: String)
    
    /// Receives the description entered in the description field
    /// - Parameter imageTitle: The movie description text
    func uploadMovieImage(imageTitle: String)
    
    var buttonValidator: CurrentValueSubject<Bool, Never> { get }
//    func validateButton()
}

class AddMovieViewModel: AddMovieViewModelProtocol {

    //MARK: - Properties
    var buttonValidator: CurrentValueSubject<Bool, Never> = CurrentValueSubject(false)
    var movie: CurrentValueSubject<MovieData?, Never> = CurrentValueSubject(nil)
    private var dataMovie: MovieData
    private let coreData: CoreDataManager
    
    //MARK: - Initializer
    init(coreData: CoreDataManager) {
        self.coreData = coreData
        self.dataMovie = MovieData(context: coreData.persistentContainer.viewContext)
    }
    
    //MARK: - AddMovieViewModelProtocol
    private func validateButton() {
        if dataMovie.imageName != nil
            && dataMovie.movieTitle != nil
            && dataMovie.describtion != nil
            && dataMovie.genresArray != nil
            && dataMovie.rating > 0 {
            buttonValidator.send(true)
        } else {
            buttonValidator.send(false)
        }
    }
    
    func addFinishedMovie() {
        dataMovie.favorite = false
        dataMovie.favoritesCount = Int32.random(in: 0...5000)
        dataMovie.date = Int32.random(in: 1940...2023)
        dataMovie.duration = Double.random(in: 85...230)
        dataMovie.viewed = Double.random(in: 150...7340)
        let cast = Cast(context: coreData.persistentContainer.viewContext)
        cast.castName = "Filip"
        cast.parent = dataMovie
        coreData.saveMovieData()
        movie.send(dataMovie)
    }
    
    func checkBox(checkBoxText: String) {
        secureGenresStacking(checkBoxText)
        validateButton()
    }
    
    private func secureGenresStacking(_ checkBoxText: String) {
        guard let genresStringArray = dataMovie.genresArray?.array as? [Genres] else { return }
        if let existingGenre = genresStringArray.first(where: { $0.genreName == checkBoxText }) {
            coreData.persistentContainer.viewContext.delete(existingGenre)
        } else {
            let genre = Genres(context: coreData.persistentContainer.viewContext)
            genre.genreName = checkBoxText
            genre.parent = dataMovie
        }
    }
    
    func starsRatingReceived(rating: Int) {
        dataMovie.rating = Double(rating)
        validateButton()
    }
    
    func receiveMovieTitle(title: String) {
        guard checkTitleTextField(text: title) else { return }
        
        dataMovie.movieTitle = title
        validateButton()
    }
    
    func receiveMovieDescrption(description: String) {
        guard checkTitleTextField(text: description) else { return }
        
        dataMovie.describtion = description
        validateButton()
    }
    
    func uploadMovieImage(imageTitle: String) {
        dataMovie.imageName = imageTitle
        validateButton()
    }
    
    //MARK: - Private Methods
    private func checkTitleTextField(text: String) -> Bool {
        let trimmedText = text.trimmingCharacters(in: .whitespaces)
        if trimmedText == "" || trimmedText.first == " " {

          return false
        }

        return true
    }
    
}
