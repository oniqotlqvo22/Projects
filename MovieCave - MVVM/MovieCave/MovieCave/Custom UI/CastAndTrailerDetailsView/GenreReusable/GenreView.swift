//
//  GenreLabel.swift
//  MovieCave
//
//  Created by Admin on 29.12.23.
//

import UIKit

class GenreView: UIView {
    
    private let label: UILabel
    
    var text: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
            updateViewSize()
        }
    }
    
    init(text: String?) {
        label = UILabel(frame: CGRect.zero)
        super.init(frame: CGRect.zero)
        
        commonInit()
        self.text = text
    }
    
    required init?(coder aDecoder: NSCoder) {
        label = UILabel(frame: CGRect.zero)
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        configureLabel()
    }

    private func configureLabel() {
        label.textColor = UIColor(red: 0.98, green: 0.85, blue: 0.12, alpha: 1)
        label.layer.cornerRadius = bounds.height / 2
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.shadowColor = UIColor.red.cgColor
        label.layer.shadowOffset = CGSize(width: 0, height: 4)
        label.layer.shadowOpacity = 0.6
        label.layer.shadowRadius = 4
    }
    
    private func updateViewSize() {
        let labelSize = label.intrinsicContentSize
        frame.size = CGSize(width: labelSize.width + 10, height: 25)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
}
