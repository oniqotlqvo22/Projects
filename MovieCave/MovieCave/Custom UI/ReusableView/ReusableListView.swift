//
//  ReusableListView.swift
//  MovieCave
//
//  Created by Admin on 11.10.23.
//

import UIKit

//MARK: - FilterButtonsDelegate
protocol FilterButtonsDelegate: NSObject {
    func buttonClicked(with buttonTitle: String)
}

class ReusableListView: UIView {

    //MARK: - IBOutlets
    @IBOutlet weak var filterBarView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    weak var collectionViewDelegate: UICollectionViewDelegate?
    weak var collectionViewDataSource: UICollectionViewDataSource?
    weak var searchBarDelegate: UISearchBarDelegate?
    weak var filterButtonsDelegate: FilterButtonsDelegate?
    private var stackView: UIStackView!
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureView()
        setUpView()
    }
    
    // MARK: - Private Methods
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "ReusableView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func setUpView() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = Constants.searchBarPlaceHolder
        searchBar.barStyle = .black
        filterBarView.addSubview(searchBar)

        searchBar.leadingAnchor.constraint(equalTo: filterBarView.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: filterBarView.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: filterBarView.safeAreaLayoutGuide.topAnchor).isActive = true

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        filterBarView.addSubview(scrollView)

        scrollView.leadingAnchor.constraint(equalTo: filterBarView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: filterBarView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: filterBarView.bottomAnchor).isActive = true

        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        scrollView.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true

    }
    
    private func resetButtons(_ ignoreButton: UIButton) {
        guard let superview = ignoreButton.superview else { return }
        
        for case let button in superview.subviews {
            if button != ignoreButton {
                button.backgroundColor = .clear
            }
        }
    }
    
    private func highlightButton(_ button: UIButton) {
        button.backgroundColor = Constants.filterButtonsHighLightColor
    }
    
    // MARK: - Public Methods
    func filterButtons(buttonTitles: [String]) {
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.backgroundColor = .clear
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    // MARK: - Action Methods
    @objc private func filterButtonTapped(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }
        
        resetButtons(sender)
        
        if sender.backgroundColor == Constants.filterButtonsHighLightColor {
            sender.backgroundColor = .clear
            return
        }
        
        highlightButton(sender)
        filterButtonsDelegate?.buttonClicked(with: senderTitle)
    }
    
}
