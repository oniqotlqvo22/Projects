//
//  PersonalInfoViewModel.swift
//  MovieCave
//
//  Created by Admin on 26.10.23.
//

import Foundation
import Combine

//MARK: - PersonalInfoViewModelProtocol
protocol PersonalInfoViewModelProtocol {
    func saveChanges()
    func removeCoordinator()
    var changeMessage: CurrentValueSubject<String?, Never> { get }
}

class PersonalInfoViewModel: PersonalInfoViewModelProtocol {
    
    //MARK: - Properties
    private weak var coordinator: PersonalInfoViewCoordinatorProtocol?
    private let apiService: MovieDBServiceProtocol
    var changeMessage: CurrentValueSubject<String?, Never> = CurrentValueSubject(nil)
    
    //MARK: - Initializer
    init(coordinator: PersonalInfoViewCoordinatorProtocol?, apiService: MovieDBServiceProtocol) {
        self.coordinator = coordinator
        self.apiService = apiService
    }
    
    //MARK: - Methods
    func saveChanges() {
        changeMessage.send("Your personal info was changed successfully.")
    }
    
    func removeCoordinator() {
        coordinator?.delocateCoordinator()
    }
    
}
