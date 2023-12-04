//
//  MovieDetailsScreenViewController.swift
//  MovieCave
//
//  Created by Admin on 2.10.23.
//

import Combine
import WebKit

class DetailsScreenViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var trailerStackView: UIStackView!
    @IBOutlet private weak var bigPosterImageView: UIImageView!
    @IBOutlet private weak var castStackView: UIStackView!
    @IBOutlet private weak var genreView: UIView!
    @IBOutlet private weak var favoritesStarLabel: UILabel!
    @IBOutlet private weak var movieYearLabel: UILabel!
    @IBOutlet private weak var movieTitleLabel: UILabel!
    @IBOutlet private weak var describtionImage: UIImageView!
    @IBOutlet private weak var describtionLabel: UILabel!
    
    //MARK: - Properties
    var viewModel: DetailsScreenViewModelProtocol?
    private var cancellables: [AnyCancellable] = []
    private var popUp: PopUpView!

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBinders()
    }
    
}

//MARK: - Video Player setUp
extension DetailsScreenViewController {
    
    func playMovieTrailer(with key: String) {
        guard let url = URL(string: Links.youTubeEmbedURL(key)) else { return }
        
        let webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)
        webView.load(URLRequest(url: url)) 
    }

}

//MARK: - View Elements setUp
extension DetailsScreenViewController {

    func setUpBinders() {
        viewModel?.mediaDetails.sink { [weak self] seriesDetails in
            guard let self,
                  let seriesDetails else { return }
            
            self.bigPosterImageView.downloaded(from: Constants.moviePosterURL + seriesDetails.bigPoster, contentMode: .scaleAspectFill)
            self.favoritesStarLabel.text = seriesDetails.avrgVote
            self.movieYearLabel.text = seriesDetails.releaseDate
            self.movieTitleLabel.text = seriesDetails.title
            self.describtionImage.downloaded(from: Constants.moviePosterURL + seriesDetails.poster)
            self.describtionLabel.text = seriesDetails.overview
            self.setUpGenreLabels(with: seriesDetails.gernes)
        }.store(in: &cancellables)

        viewModel?.mediaCast.sink { [weak self] castArray in
            guard let self,
                  let castArray else { return }

            DispatchQueue.main.async {
                self.setUpCast(with: castArray)
            }
        }.store(in: &cancellables)

        viewModel?.mediaVideos.sink { [weak self] videos in
            guard let self,
                  let videos else { return }
            
            DispatchQueue.main.async {
                self.setUpTrailers(with: videos)
            }
        }.store(in: &cancellables)
        
        viewModel?.popUpMessage.sink { [weak self] message in
            guard let self,
                  let message else { return }
            
            self.popUp = PopUpView(frame: self.view.bounds, inVC: self, messageLabelText: message)
            self.view.addSubview(self.popUp)
        }.store(in: &cancellables)

    }

    func setUpGenreLabels(with genres: [String]) {
        var xPosition: CGFloat = 8
        var yPosition: CGFloat = 0
        var row = 0
        var currentRowHighestElement: CGFloat = 0
        for genre in genres {
            let label = UILabel()
            label.text = genre
            label.textAlignment = .center
            label.numberOfLines = 0
            
            label.frame.size = CGSize(width: genre.count * 12, height: 25)
            label.layer.cornerRadius = label.frame.size.height / 2
            label.textColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
            label.layer.shadowColor = UIColor.darkGray.cgColor
            label.layer.shadowOffset = CGSize(width: 0, height: 4)
            label.layer.shadowOpacity = 0.5
            label.layer.shadowRadius = 4
            
            if label.frame.size.height > currentRowHighestElement {
                currentRowHighestElement = label.frame.size.height
            }
            
            if label.frame.width >= genreView.frame.size.width - xPosition {
                row += 1
                yPosition += currentRowHighestElement + 32
                xPosition = 0
                currentRowHighestElement = 0
            }
            
            label.frame.origin = CGPoint(x: xPosition, y: yPosition + 16)
            genreView.addSubview(label)
            
            xPosition += label.frame.size.width + 16
        }
    }

    func setUpCast(with castArray: [MediaCast]) {
        for actior in castArray {
            let cast = CastAndTrailerDetailsView()
            cast.wantCircularImage = true
            cast.translatesAutoresizingMaskIntoConstraints = false
            cast.widthAnchor.constraint(equalToConstant: 70).isActive = true
            cast.clipsToBounds = true
            cast.layer.masksToBounds = true
            cast.imageView.layer.borderWidth = 2.0
            cast.imageView.layer.borderColor = UIColor.white.cgColor
            cast.label.text = actior.name
            cast.imageView.downloaded(from: Constants.moviePosterURL + (actior.poster ?? "no image"))
            castStackView.addArrangedSubview(cast)
        }
    }

    func setUpTrailers(with trailers: [MediaVideos]) {
        for video in trailers {
            let trailerView = CastAndTrailerDetailsView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(trailerTapped(_:)))
            trailerView.translatesAutoresizingMaskIntoConstraints = false
            trailerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            trailerView.clipsToBounds = true
            trailerView.layer.masksToBounds = true
            let playIconImage = UIImage(named: "play-button")?.resizeImage(targetSize: CGSize(width: 45, height: 35))
            let playIconImageView = UIImageView(image: playIconImage)
            playIconImageView.contentMode = .center
            playIconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            trailerView.movieID = video.key
            trailerView.imageView.backgroundColor = .black
            trailerView.label.text = video.name
            trailerView.addGestureRecognizer(tap)
            trailerView.isUserInteractionEnabled = true
            trailerView.addSubview(playIconImageView)
            trailerStackView.addArrangedSubview(trailerView)
            
            NSLayoutConstraint.activate([
                playIconImageView.centerXAnchor.constraint(equalTo: trailerView.centerXAnchor),
                playIconImageView.centerYAnchor.constraint(equalTo: trailerView.centerYAnchor, constant: -25)
            ])
        }
    }

    @objc func trailerTapped(_ tap: UITapGestureRecognizer) {
        guard let trailerView = tap.view as? CastAndTrailerDetailsView else { return }
        UIView.animate(withDuration: 0.2, animations: {
            trailerView.alpha = 0.5
        }) { _ in
            UIView.animate(withDuration: 0.2) {
                trailerView.alpha = 1.0
            }
        }

        playMovieTrailer(with: trailerView.movieID)
    }

}
