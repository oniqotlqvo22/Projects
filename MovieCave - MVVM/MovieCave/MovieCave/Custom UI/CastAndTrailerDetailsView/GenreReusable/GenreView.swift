//
//  GenreLabel.swift
//  MovieCave
//
//  Created by Admin on 29.12.23.
//

import UIKit

class GenreView: UIView {
    
    //MARK: - Properties
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
    
    //MARK: - Initialization
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
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
    //MARK: - Private methods
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
        label.textColor = Constants.genreLabelColor
        label.layer.cornerRadius = bounds.height / Constants.cornerRadiusDevider
        label.textAlignment = .center
        label.numberOfLines = Constants.numberOfLinesOne
        label.layer.shadowColor = UIColor.red.cgColor
        label.layer.shadowOffset = Constants.genreViewLabelShadowOffset
        label.layer.shadowOpacity = Constants.genreViewLabelShadowOpacity
        label.layer.shadowRadius = Constants.genreViewLabelShadowRadius
    }
    
    private func updateViewSize() {
        let labelSize = label.intrinsicContentSize
        frame.size = CGSize(width: labelSize.width + Constants.gerneViewFrameAdditionalWidth, height: Constants.gerneViewFrameHeight)
    }

}
