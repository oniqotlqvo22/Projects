//
//  MovieDetailsViewController.swift
//  Movie-Cave
//
//  Created by Admin on 3.09.23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var trailerStackView: UIStackView!
    @IBOutlet weak var bigPosterImageView: UIImageView!
    @IBOutlet weak var castStackView: UIStackView!
    
    let trailerURLs: [String] = ["url1", "url2", "url3", "url3", "url3"]
    let castArray = ["url1", "url2", "url3", "url3", "url3"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if trailerURLs == [] {
            trailerStackView = nil
        }
        bigPosterImageView.image = UIImage(named: "yasuke")?.resizeImage(targetSize: CGSize(width: 240, height: 225))
        setUpTrailers()
        setUpCast()
    }
    
    func setUpCast() {
        for url in castArray {
            let cast = MovieView()
            cast.wantCircularImage = true
            cast.translatesAutoresizingMaskIntoConstraints = false
            cast.widthAnchor.constraint(equalToConstant: 70).isActive = true
            cast.clipsToBounds = true
            cast.layer.masksToBounds = true
            cast.imageView.layer.borderWidth = 2.0
            cast.imageView.layer.borderColor = UIColor.white.cgColor
            cast.imageView.image = UIImage(named: "yasuke")?.resizeImage(targetSize: CGSize(width: 240, height: 260))
            cast.label.text = url
            castStackView.addArrangedSubview(cast)
        }
    }
    
    func setUpTrailers() {
        for url in trailerURLs {
            let trailerView = MovieView()
            let tap = UITapGestureRecognizer(target: self, action: #selector(trailerTapped(_:)))
            trailerView.translatesAutoresizingMaskIntoConstraints = false
            trailerView.widthAnchor.constraint(equalToConstant: 120).isActive = true
            trailerView.layer.cornerRadius = 10
            trailerView.clipsToBounds = true
            trailerView.layer.masksToBounds = true
            trailerView.imageView.layer.borderWidth = 2.0
            trailerView.imageView.layer.borderColor = UIColor.black.cgColor
            trailerView.imageView.image = UIImage(named: "yasuke")?.resizeImage(targetSize: CGSize(width: 240, height: 260))
            trailerView.label.text = url
            trailerView.addGestureRecognizer(tap)
            trailerStackView.addArrangedSubview(trailerView)
        }
    }
    
    @objc func trailerTapped(_ tap: UITapGestureRecognizer) {
      guard let trailerView = tap.view as? MovieView else { return }
        
        print("Trailer tapped at index: \(trailerView.label.text)")
    }
    
}


class MovieView: UIView {
    
    let imageView = UIImageView()
    let label = UILabel()
    var wantCircularImage = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.textAlignment = .center
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard wantCircularImage else { return }

        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.white.cgColor
    }

}
