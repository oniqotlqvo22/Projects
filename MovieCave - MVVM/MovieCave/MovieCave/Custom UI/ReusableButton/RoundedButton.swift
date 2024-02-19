//
//  RoundedButton.swift
//  MovieCave
//
//  Created by Admin on 26.10.23.
//

import UIKit

class RoundedButton: UIButton {
    
    //MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = bounds.height / Constants.roundedButtonCornerRadiusDevider
        
        backgroundColor = Constants.roundedButtonBackgroundColor
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = Constants.roundedButtonLayerShadowOffset
        layer.shadowRadius = Constants.roundedButtonLayerShadowRadius
        layer.shadowOpacity = Constants.roundedButtonLayerShadowOpacity
        
        addTarget(self, action: #selector(buttonPressed), for: .touchDown)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpInside)
        addTarget(self, action: #selector(buttonReleased), for: .touchUpOutside)
        addTarget(self, action: #selector(buttonReleased), for: .touchCancel)
    }
    
    //MARK: - Methods
    @objc private func buttonPressed() {
        backgroundColor = UIColor.lightGray
    }
    
    @objc private func buttonReleased() {
        backgroundColor = Constants.roundedButtonBackgroundColor
    }
}

