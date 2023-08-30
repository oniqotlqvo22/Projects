//
//  TestView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

class TestView: UIView {
    
    
    @IBOutlet var view: TestView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        setUpView()
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "TestView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }

    func setUpView() {
        
        // Create a search bar
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        view.addSubview(searchBar)
        
        // Add constraints to the search bar
        searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        // Create a scroll view
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        // Add constraints to the scroll view
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        // Create a stack view to hold the buttons
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        scrollView.addSubview(stackView)
        
        // Add constraints to the stack view
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -8).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        // Create buttons and add them to the stack view
        let buttonsTitles: [String] = ["Most popular", "Longest", "Raiting", "Newest", "Genre"]
        for buttons in buttonsTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttons, for: .normal)
            button.backgroundColor = .black
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 25).isActive = true
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)

        }
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        // Handle button tap event
        print("Button tapped: \(sender.titleLabel?.text ?? "")")
    }
    
}
