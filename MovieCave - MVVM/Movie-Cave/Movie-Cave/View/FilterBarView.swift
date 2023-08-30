//
//  FilterBarView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

class FilterBarView: UIView {

    
    @IBOutlet private weak var searchBark: UISearchBar!
    @IBOutlet private weak var buttonOne: UIButton!
    @IBOutlet private weak var buttonTwo: UIButton!
    @IBOutlet private weak var buttonThree: UIButton!
    @IBOutlet private weak var buttonFive: UIButton!
    @IBOutlet private weak var buttonFour: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "FilterBarView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let buttonTapped = sender.currentTitle else { return }
        
        switch buttonTapped {
        case "ButtonOne":
            print("1")
        case "ButtonTwo":
            print("2")
        case "ButtonThree":
            print("3")
        case "ButtonFour":
            print("4")
        case "ButtonFive":
            print("5")
        default:
            break
        }
      
    }
    

}
