//
//  CoreDataManager.swift
//  Movie-Cave
//
//  Created by Admin on 10.09.23.
//

import Foundation
import CoreData

//MARK: - CoreDataManager
struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MoviesData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()
    
    func saveMovieData() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Failed to create: \(error)")
        }
    }
    
    func loadMovies() -> [MovieData]? {
        let fetchRequest = NSFetchRequest<MovieData>(entityName: "MovieData")

        do {
            let movies = try persistentContainer.viewContext.fetch(fetchRequest)

            return movies
        } catch {
         print("Error fetching data from context \(error)")
        }
        
        return nil
    }
    
    func deleteMovie(movie: MovieData) {
        persistentContainer.viewContext.delete(movie)
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            print("Failed to delete: \(error)")
        }
    }

}
