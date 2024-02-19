//
//  File.swift
//  MovieCave
//
//  Created by Admin on 2.10.23.
//

import UIKit
import WebKit

protocol TrailerViewDelegate: AnyObject {
    /// Tells the delegate that the play button was tapped on the trailer view.
    /// - Parameter trailerView: The trailer view whose play button was tapped.
    func trailerViewDidTapPlayButton(_ trailerView: TrailerView)
}

protocol TrailerViewProtocol: AnyObject {
    
    /// Configures the view with a video key, label text and width constraint.
    /// - Parameters:
    ///   - videoKey:  The video key for the trailer.
    ///   - labelText: The text to display for the trailer label.
    ///   - widthAnchorConst: The constraint to use for the width anchor.
    func configureView(videoKey: String, labelText: String, widthAnchorConst: CGFloat)
    
    /// Plays the movie trailer in the given view controller view.
    /// - Parameter view: The parent view controller's view to display the trailer in.
    func playMovieTrailer(in view: UIView)
    
    /// The trailer view's delegate to notify when events occur.
    var delegate: TrailerViewDelegate? { get set }
}

class TrailerView: UIView, TrailerViewProtocol {
    
    //MARK: - Properties
    private let imageView = UIImageView()
    private let label = UILabel()
    private var movieID: String?
    weak var delegate: TrailerViewDelegate?
    
    //MARK: - TrailerViewProtocol Methods
    func configureView(videoKey: String, labelText: String, widthAnchorConst: CGFloat) {
        movieID = videoKey
        setUpView(widthAnchorConst: widthAnchorConst)
        setUpPlayImage()
        setUpLabelText(with: labelText)
        setUpThumbnail(videoKey: videoKey)
    }
    
    func playMovieTrailer(in view: UIView) {
        guard let movieID,
              let url = URL(string: Links.youTubeEmbedURL(movieID)) else { return }
        
        let webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        webView.load(URLRequest(url: url))
    }
    
    //MARK: - Private
    private func setUpLabelText(with text: String) {
        label.text = text
    }
    
    private func setUpThumbnail(videoKey: String) {
        DispatchQueue.main.async { [weak imageView] in
            imageView?.downloaded(from: Links.youTubeThumbnail(videoKey))
        }
    }
    
    private func setUpPlayImage() {
        let playIconImage = UIImage(named: Constants.playButtonImage)?.resizeImage(targetSize: Constants.trailerPlayIconImageSize)
        let playIconImageView = UIImageView(image: playIconImage)
        playIconImageView.contentMode = .center
        playIconImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(playIconImageView)
        NSLayoutConstraint.activate([
            playIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            playIconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: Constants.playIconImageViewCenterYAnchorConstraintConst)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(playButtonTapped))
        playIconImageView.addGestureRecognizer(tapGesture)
        playIconImageView.isUserInteractionEnabled = true
    }
    
    @objc private func playButtonTapped() {
        UIView.animate(withDuration: Constants.trailerPlayButtonAnimateDuration, animations: {
            self.alpha = Constants.trailerPlayButtonAlphaOnPress
        }) { _ in
            UIView.animate(withDuration: Constants.trailerPlayButtonAnimateDuration) {
                self.alpha = Constants.trailerPlayButtonAlphaOnRelease
            }
        }
        delegate?.trailerViewDidTapPlayButton(self)
    }
    
    private func setUpView(widthAnchorConst: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
        self.widthAnchor.constraint(equalToConstant: widthAnchorConst).isActive = true
        addSubview(label)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.trailerImageViewHeightAnchorConstant).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.trailerViewLabelTopAnchorConstraint).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: Constants.trailerViewLabelHeightAnchorConstraint).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: Constants.trailerViewLabelBottomAnchorConstraint).isActive = true
        label.numberOfLines = Constants.labelNumberOfLinesZero
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
    }
}
