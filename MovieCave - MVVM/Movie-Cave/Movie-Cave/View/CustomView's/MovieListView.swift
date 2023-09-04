//
//  MovieListView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit
// MARK: - Extension of Array
extension Array {
    /// This extension adds a subscript to the Array protocol that allows safe access to elements of the collection. It returns an optional element at the specified index, which will be nil if the index is out of bounds.
    /// - Parameters: This subscript takes one parameter: the index of the element to access.
    /// - Returns: This subscript returns an optional element of the collection at the specified index. If the index is out of bounds, nil is returned.
    subscript(from index: Int) -> Element? {
        guard self.count > index,
              index >= 0 else { return nil }
        
        return self[index]
    }
}
protocol MovieListViewDelegate {
    func didTapButton(in cell: MoviesCollectionViewCell, for movie: Movie)
}

class MovieListView: UIView {

    @IBOutlet private weak var collectionView: UICollectionView!
    var movies: [Movie] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    weak var moviesDelegate: MoviesCollectionViewCellDelegate?
    var delegate: MovieListViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "MovieListView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private var favoriteButton: UIButton!
    private let emptyStar = UIImage(systemName: "star")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    private let filledStar = UIImage(systemName: "star.fill")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    var favorite = false
}

extension MovieListView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("\(movies[indexPath.row].movieTitle)")
        print(movies[indexPath.row].favorite)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier,
                                                            for: indexPath) as? MoviesCollectionViewCell else {
            return MoviesCollectionViewCell()
        }
        
        favoriteButton = UIButton(frame: CGRect(x:1, y:1, width:40,height:40))
        favoriteButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        cell.addSubview(favoriteButton)
        cell.movie = movies[from: indexPath.row]
    
        return cell
    }
    
    @objc func editButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview as? MoviesCollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell) else { return }

        movies[indexPath.row].favorite.toggle()
        delegate?.didTapButton(in: cell, for: movies[indexPath.row])
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
