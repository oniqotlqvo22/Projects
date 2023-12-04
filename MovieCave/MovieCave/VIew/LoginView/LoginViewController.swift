//
//  ViewController.swift
//  MovieCave
//
//  Created by Admin on 20.09.23.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    
    //MARK: - Properties
    var viewModel: LoginViewModelProtocol?
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    //MARK: - IBActions
    @IBAction func logInButtonPress(_ sender: UIButton) {
        viewModel?.logIn()
    }
    
}

