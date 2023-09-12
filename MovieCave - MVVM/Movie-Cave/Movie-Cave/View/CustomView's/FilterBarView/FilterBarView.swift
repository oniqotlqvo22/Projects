//
//  TestView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

//MARK: - FilterBarViewDelegate
protocol FilterBarViewDelegate {
    func genreButton(_ genre: String)
    func searchBar(_ text: String)
    func searchBarDidClear()
}

class FilterBarView: UIView {
    
    //MARK: - IBOutlets
    @IBOutlet private var view: FilterBarView!
    
    //MARK: - Properties
    private let searchBar = UISearchBar()
    private var lastSearchTxt = ""
    var filterBarDelegate: FilterBarViewDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpView()
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        setUpView()
        searchBar.delegate = self
    }
    
    //MARK: - Private Methods
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: Constants.filterBarViewNibName) else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }
        
        resetButtons(sender)
        if sender.backgroundColor == Constants.filterButtonsHighLightColor {
            sender.backgroundColor = .clear
            return
        }
        highlightButton(sender)
        
        switch senderTitle {
        case Constants.mostPopularFilterButton:
            filterBarDelegate?.genreButton(senderTitle)
        case Constants.longestFilterButton:
            filterBarDelegate?.genreButton(senderTitle)
        case Constants.ratingFilterButton:
            filterBarDelegate?.genreButton(senderTitle)
        case Constants.newestFilterButton:
            filterBarDelegate?.genreButton(senderTitle)
        default:
            break
        }
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
    
}

//MARK: - UISearchBarDelegate
extension FilterBarView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }

        filterBarDelegate?.searchBar(searchBarText)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchBar.text != "" else {
            NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.makeNetworkCall), object: lastSearchTxt)
            filterBarDelegate?.searchBarDidClear()
            return
        }
        
        if lastSearchTxt.isEmpty {
            lastSearchTxt = searchText
        }

        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.makeNetworkCall), object: lastSearchTxt)
        lastSearchTxt = searchText
        self.perform(#selector(self.makeNetworkCall), with: searchText, afterDelay: 0.5)
    }
    
    @objc private func makeNetworkCall(sender: String) {
        filterBarDelegate?.searchBar(sender)
    }

}

//MARK: - FilterBarView UI setup
extension FilterBarView {
    
    private func setUpView() {

        view.layer.borderWidth = 3
        view.layer.borderColor = CGColor(red: 0.45, green: 0.20, blue: 0.25, alpha: 0.65)
        view.layer.cornerRadius = 5
        view.backgroundColor = .black
        self.backgroundColor = .black
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = Constants.searchBarPlaceHolder
        searchBar.barTintColor = .black
        searchBar.searchTextField.backgroundColor = .white
        view.addSubview(searchBar)
        
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        let stackView = UIStackView()
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
        
        let buttonsTitles: [String] = [Constants.mostPopularFilterButton,
                                       Constants.longestFilterButton,
                                       Constants.ratingFilterButton,
                                       Constants.newestFilterButton]
        for buttons in buttonsTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttons, for: .normal)
            button.backgroundColor = .clear
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.layer.cornerRadius = 5
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
}
