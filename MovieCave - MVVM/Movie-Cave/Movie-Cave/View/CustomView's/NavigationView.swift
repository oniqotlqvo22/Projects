//
//  NavigationView.swift
//  Movie-Cave
//
//  Created by Admin on 29.08.23.
//

import UIKit

class NavigationView: UIView {

    
    @IBOutlet private weak var moviesButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!
    @IBOutlet private weak var addMovieButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "NavigationView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonTapped = sender.currentTitle else { return }
        
        switch buttonTapped {
        case "Movies":
            print("Movie")
        case "Add Movie":
            print("Add Movie")
        case "Profile":
            print("Profile")
        default:
            break
        }
      
    }
    
    
    
}
