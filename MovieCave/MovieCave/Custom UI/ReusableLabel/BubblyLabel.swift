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
        
        layer.cornerRadius = bounds.height / 2
        backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)

        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
    }
}
