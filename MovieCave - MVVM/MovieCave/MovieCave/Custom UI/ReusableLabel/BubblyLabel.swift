//
//  label.swift
//  MovieCave
//
//  Created by Admin on 26.10.23.
//

import UIKit

class BubblyLabel: UILabel {
    
    //MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = bounds.height / Constants.bubblyLabelCornerRadiusDevider
        backgroundColor = Constants.bubblyLabelBackgroundColor

        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = Constants.bubblyLabelLayerShadowOffset
        layer.shadowRadius = Constants.bubblyLabelLayerShadowRadius
        layer.shadowOpacity = Constants.bubblyLabelLayerShadowOpacity
    }
}
