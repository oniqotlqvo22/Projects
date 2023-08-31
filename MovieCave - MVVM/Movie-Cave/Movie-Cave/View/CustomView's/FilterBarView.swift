//
//  TestView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

protocol FilterBarViewDelegate {
    func genreButton(_ genre: String)
    func searchBar(_ text: String)
}

class FilterBarView: UIView {
    
    @IBOutlet private var view: FilterBarView!
    private let searchBar = UISearchBar()
    private var lastSearchTxt = ""
    var filterBarDelegate: FilterBarViewDelegate?
    
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
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "FilterBarView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let senderTitle = sender.currentTitle else { return }
        
        resetButtons(sender)
        if sender.backgroundColor == .green {
            sender.backgroundColor = .clear
            return
        }
        highlightButton(sender)
        
        switch senderTitle {
        case "Most popular":
            filterBarDelegate?.genreButton(senderTitle)
        case "Longest":
            filterBarDelegate?.genreButton(senderTitle)
        case "Raiting":
            filterBarDelegate?.genreButton(senderTitle)
        case "Newest":
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
        button.backgroundColor = .green
    }
    
}

extension FilterBarView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text else { return }

        filterBarDelegate?.searchBar(searchBarText)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if lastSearchTxt.isEmpty {
            lastSearchTxt = searchText
        }
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.makeNetworkCall), object: lastSearchTxt)
        lastSearchTxt = searchText
        self.perform(#selector(self.makeNetworkCall), with: searchText, afterDelay: 0.5)
    }
    
    @objc private func makeNetworkCall(sender: String) {
        
//        filterBarDelegate?.searchBar(sender)
    }

}

extension FilterBarView {
    
    private func setUpView() {

        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
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
        
        let buttonsTitles: [String] = ["Most popular", "Longest", "Raiting", "Newest"]
        for buttons in buttonsTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttons, for: .normal)
            button.backgroundColor = .white
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
}
