//
//  TabPages.swift
//  MovieCave
//
//  Created by Admin on 26.09.23.
//

import UIKit

enum TabBarPage {
    case movies
    case tvSeries
    case profile

    init?(index: Int) {
        switch index {
        case 0:
            self = .movies
        case 1:
            self = .tvSeries
        case 2:
            self = .profile
        default:
            return nil
        }
    }

    func pageTitleValue() -> String {
        switch self {
        case .movies:
            return "Movies"
        case .tvSeries:
            return "TV Series"
        case .profile:
            return "Profile"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .movies:
            return 0
        case .tvSeries:
            return 1
        case .profile:
            return 2
        }
    }

    func pageIcon() -> UIImage {
        switch self {
        case .movies:
            return UIImage(systemName: "film")!
        case .tvSeries:
            return UIImage(systemName: "plus.app")!
        case .profile:
            return UIImage(systemName: "person.text.rectangle")!
        }
    }

}

