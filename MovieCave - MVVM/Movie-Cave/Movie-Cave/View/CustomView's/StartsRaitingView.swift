//
//  StartsRaitingView.swift
//  Movie-Cave
//
//  Created by Admin on 9.09.23.
//

import UIKit

//MARK: - StarsRaitingViewDelegate
protocol StarsRaitingViewDelegate {
    func starsReceived(rate: Int)
}

class StartsRaitingView: UIStackView {

    //MARK: - Properties
    private let startsCount: Int = 5
    private var selectedRate: Int = 0
    private let feedBackGenerator = UISelectionFeedbackGenerator()
    var delegate: StarsRaitingViewDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpStars()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didSelectStar))
        self.addGestureRecognizer(gesture)
        self.axis = .horizontal
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 8
        
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    //MARK: - Private Methods
    @objc func didSelectStar(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        let starWidht = self.bounds.width / CGFloat(startsCount)
        let rate = Int(location.x / starWidht) + 1
        
        if rate != selectedRate {
            feedBackGenerator.selectionChanged()
            selectedRate = rate
        }
        
        self.arrangedSubviews.forEach { starViews in
            guard let starImageView = starViews as? UIImageView else { return }
            
            starImageView.isHighlighted = starImageView.tag <= rate
        }
        
        delegate?.starsReceived(rate: rate)
    }

    private func setUpStars() {
        for starNum in 1...startsCount {
            let starIcon = createStarIcon()
            starIcon.tag = starNum
            self.addArrangedSubview(starIcon)
            layoutIfNeeded()
        }
        
    }
    
    private func createStarIcon() -> UIImageView {
        let imageView = UIImageView(image: UIImage(named: "star_blank"),
                                    highlightedImage: UIImage(named: "star_end"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
}
