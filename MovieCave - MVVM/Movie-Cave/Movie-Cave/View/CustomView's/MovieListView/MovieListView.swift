//
//  MovieListView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

//MARK: - MovieListViewDelegate
protocol MovieListViewDelegate {
    func favoriteButtonTapped(in cell: MoviesCollectionViewCell)
    func movieTapedFromCell(for movie: MovieData)
}

class MovieListView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    var movies: [MovieData] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var favoriteButton: UIButton!
    var delegate: MovieListViewDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.MoviesCollectionCellidentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.MoviesCollectionCellidentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    //MARK: - Private Methods
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: Constants.movieListNibName) else { return }
        
        view.frame = self.bounds
        collectionView.backgroundColor = .black
        self.addSubview(view)
    }
    
}



//MARK: - CollectionViewDelegate & DataSource & DelegateFlowLayout
extension MovieListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        delegate?.movieTapedFromCell(for: movies[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MoviesCollectionCellidentifier,
                                                            for: indexPath) as? MoviesCollectionViewCell else {
            return MoviesCollectionViewCell()
        }
        
        favoriteButton = UIButton(frame: CGRect(x:1, y:1, width:Constants.favoriteButtonWidth, height:Constants.favoriteButtonHeight))
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        cell.addSubview(favoriteButton)
        cell.movie = movies[indexPath.row]
    
        return cell
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview as? MoviesCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }

        movies[indexPath.row].favorite.toggle()
        delegate?.favoriteButtonTapped(in: cell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width / 2) - 1,
                      height: (self.frame.width / 2) - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

}
