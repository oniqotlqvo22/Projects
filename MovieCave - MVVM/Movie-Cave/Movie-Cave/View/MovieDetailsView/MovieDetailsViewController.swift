//
//  MovieDetailsViewController.swift
//  Movie-Cave
//
//  Created by Admin on 3.09.23.
//

import UIKit
import Combine
import AVKit
import AVFoundation

class MovieDetailsViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var trailerStackView: UIStackView!
    @IBOutlet private weak var bigPosterImageView: UIImageView!
    @IBOutlet private weak var castStackView: UIStackView!
    @IBOutlet private weak var genreView: UIView!
    @IBOutlet private weak var favoritesStarLabel: UILabel!
    @IBOutlet private weak var movieYearLable: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var describtionImage: UIImageView!
    @IBOutlet private weak var describtionLabel: UILabel!
    
    //MARK: - Properties
    private var trailerURLs: [String] = ["url1", "url2", "url3", "url3", "url3"]
    private var castArray: [Cast] = []
    private var genres: [Genres] = []
    private var viewModel: MovieDetailsViewModelProtocol?
    private var cancellables: [AnyCancellable] = []
    private let videoURL = Bundle.main.url(forResource: "angryBirds", withExtension: "mp4")
    var movie: MovieData? {
        didSet {
            guard let movie else { return }
            
            viewModel = MovieDetailsViewModel(movie: movie)
        }
    }
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
        if trailerURLs == [] {
            trailerStackView = nil
        }
        setUpTrailers()
        setUpCast()
        setUpGenreLabels()
        setUpView()
    }
    
}

//MARK: - Video Player setUp
extension MovieDetailsViewController {
    
    func playMovieTrailer(with url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        present(playerViewController, animated: true) {
            player.play()
        }
    }
    
}

extension MovieDetailsViewController {
    
    func setUpView() {
        describtionImage.layer.borderWidth = 2
        describtionImage.layer.borderColor = CGColor(red: 0.35, green: 0.60, blue: 0.20, alpha: 0.65)
        describtionImage.layer.cornerRadius = 10
        
        describtionLabel.layer.masksToBounds = true
        describtionLabel.layer.borderWidth = 2
        describtionLabel.layer.borderColor = CGColor(red: 0.64, green: 0.32, blue: 0.25, alpha: 0.65)
        describtionLabel.layer.cornerRadius = 10
    }
    func setUpBinders() {
        viewModel?.movieDetail.sink { [weak self] movie in
            guard let self,
                  let movie else { return }
            
            self.bigPosterImageView.image = UIImage().loadImageFromDocumentsDirectory(withName: movie.imageName ?? "")
            self.favoritesStarLabel.text = "\(movie.favoritesCount)"
            self.movieYearLable.text = "\(movie.date)"
            self.movieTitleLabel.text = movie.movieTitle
            self.describtionImage.image = UIImage().loadImageFromDocumentsDirectory(withName: movie.imageName ?? "")
            self.describtionLabel.text = movie.describtion
            self.castArray = movie.castArray?.array as! [Cast]
            self.genres = movie.genresArray?.array as! [Genres]
        }.store(in: &cancellables)
    }
    
    func setUpGenreLabels() {
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = 0
        var row = 0
        var currentRowHighestElement: CGFloat = 0
        for genre in genres {
            guard let genreName = genre.genreName else { return }
            
            let label = UILabel()
            label.text = genreName
            label.clipsToBounds = true
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.numberOfLines = 0
            
            label.layer.cornerRadius = 10
            label.layer.borderWidth = 2
            label.layer.borderColor = UIColor.opaqueSeparator.cgColor
            label.backgroundColor = UIColor(red: 0.35, green: 0.55, blue: 0.49, alpha: 1.00)
            label.textColor = .white
            label.layer.shadowColor = UIColor.gray.cgColor
            label.layer.shadowOffset = CGSize(width: 2, height: 2)
            label.layer.shadowOpacity = 0.7
            label.layer.shadowRadius = 4
            label.frame.size = CGSize(width: genreName.count * 12, height: 25)
            
            if label.frame.size.height > currentRowHighestElement {
                currentRowHighestElement = label.frame.size.height
            }
            
            if label.frame.width >= genreView.frame.size.width - xPosition {
                row += 1
                yPosition += currentRowHighestElement + 35
                xPosition = 0
                currentRowHighestElement = 0
            }
            
            label.frame.origin = CGPoint(x: xPosition, y: yPosition + 30)
            genreView.addSubview(label)
            
            xPosition += label.frame.size.width + 8
        }
        
    }
    
    func setUpCast() {
        for actior in castArray {
            let cast = MovieCastAndTrailerDetailsView()
            cast.wantCircularImage = true
            cast.translatesAutoresizingMaskIntoConstraints = false
            cast.widthAnchor.constraint(equalToConstant: 70).isActive = true
            cast.clipsToBounds = true
            cast.layer.masksToBounds = true
            cast.imageView.layer.borderWidth = 2.0
            cast.imageView.layer.borderColor = UIColor.white.cgColor
            cast.imageView.image = UIImage(named: "yasuke")?.resizeImage(targetSize: CGSize(width: 240, height: 260))
            cast.label.text = actior.castName
            castStackView.addArrangedSubview(cast)
        }
    }
    
    func setUpTrailers() {
        
        for url in trailerURLs {
            let trailerView = MovieCastAndTrailerDetailsView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(trailerTapped(_:)))
            trailerView.translatesAutoresizingMaskIntoConstraints = false
            trailerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            trailerView.clipsToBounds = true
            trailerView.layer.masksToBounds = true
            trailerView.imageView.layer.borderWidth = 2.0
            trailerView.imageView.layer.borderColor = UIColor.black.cgColor
            
            let playIconImage = UIImage(named: "playButtonIcon")?.resizeImage(targetSize: CGSize(width: 45, height: 35))
            let playIconImageView = UIImageView(image: playIconImage)
            playIconImageView.contentMode = .center
            playIconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            
            trailerView.imageView.image = videoURL?.generateThumbnail()
            trailerView.label.text = url
            trailerView.addGestureRecognizer(tap)
            trailerView.isUserInteractionEnabled = true
            trailerView.addSubview(playIconImageView)
            trailerStackView.addArrangedSubview(trailerView)
            
            NSLayoutConstraint.activate([
                playIconImageView.centerXAnchor.constraint(equalTo: trailerView.centerXAnchor),
                playIconImageView.centerYAnchor.constraint(equalTo: trailerView.centerYAnchor, constant: -8)
            ])
        }
        
    }
    
    @objc func trailerTapped(_ tap: UITapGestureRecognizer) {
        guard let trailerView = tap.view as? MovieCastAndTrailerDetailsView else { return }
        UIView.animate(withDuration: 0.2, animations: {
            trailerView.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                trailerView.alpha = 1.0
            }
        }
        playMovieTrailer(with: videoURL!)
    }
    
}
