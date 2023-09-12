//
//  NavigationView.swift
//  Movie-Cave
//
//  Created by Admin on 29.08.23.
//

import UIKit

//MARK: - NavigationViewDelegate
protocol NavigationViewDelegate {
    func buttonTapped()
}

class NavigationView: UIView {

    //MARK: - IBOutlets
    @IBOutlet private weak var moviesButton: UIButton!
    @IBOutlet private weak var profileButton: UIButton!
    @IBOutlet private weak var addMovieButton: UIButton!
    
    //MARK: - Properties
    var delegate: NavigationViewDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    //MARK: - IBActions
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonTapped = sender.currentTitle else { return }
        
        switch buttonTapped {
        case Constants.moviesNavigationButton:
            delegate?.buttonTapped()
        case Constants.addMovieNavigationButton:
            delegate?.buttonTapped()
        case Constants.profileNavigationButton:
            delegate?.buttonTapped()
        default:
            break
        }
      
    }
    
    //MARK: - Private Methods
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: Constants.navigationViewNibName) else { return }
        
        moviesButton.layer.cornerRadius = 5
        profileButton.layer.cornerRadius = 5
        addMovieButton.layer.cornerRadius = 5
        view.frame = self.bounds
        self.addSubview(view)
    }
    
}
