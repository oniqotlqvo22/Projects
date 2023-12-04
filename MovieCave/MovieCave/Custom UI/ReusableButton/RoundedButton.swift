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
        
        layer.cornerRadius = bounds.height / 2
        
        backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
        
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        
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
        backgroundColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
    }
}

