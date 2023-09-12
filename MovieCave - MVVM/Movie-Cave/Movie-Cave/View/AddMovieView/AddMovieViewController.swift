//
//  AddMovieViewController.swift
//  Movie-Cave
//
//  Created by Admin on 7.09.23.
//

import UIKit
import Combine

class AddMovieViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet private weak var genreCheckView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet private weak var raitingView: UIView!
    @IBOutlet private weak var genreView: UIView!
    @IBOutlet private weak var doneButton: UIButton!
    @IBOutlet private weak var movieImageButton: UIButton!
    @IBOutlet private weak var movieTitleTextField: UITextField!
    @IBOutlet private weak var describtionTextField: UITextField!
    
    //MARK: - Properties
    var movieCompletion: ((MovieData) -> Void)?
    private var coreData: CoreDataManager = CoreDataManager.shared
    private lazy var viewModel: AddMovieViewModelProtocol = {
        return AddMovieViewModel(coreData: coreData)
    }()
    private let imagePicker = UIImagePickerController()
    private let starRaitingView = StartsRaitingView()
    private var cancellables: [AnyCancellable] = []

    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegates()
        raitingView.addSubview(starRaitingView)
        starRaitingView.frame = raitingView.bounds
        addGenreChecks()
        gerneViewSetUp()
        setUpDoneButton()
        setUpBinders()
    }
    
    //MARK: - IBActions
    @IBAction func imageButtonTapped(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        viewModel.addFinishedMovie()
        navigationController?.popViewController(animated: true)
    }
    
}

//MARK: - CustomCheckBoxViewDelegate
extension AddMovieViewController: CustomCheckBoxViewDelegate {
    func checkedBox(text: String) {
        viewModel.checkBox(checkBoxText: text)
    }

}

//MARK: - StarRaitingDelegate
extension AddMovieViewController: StarsRaitingViewDelegate {
    
    func starsReceived(rate: Int) {
        viewModel.starsRatingReceived(rating: rate)
    }
    
}

//MARK: - TextFiled Delegate
extension AddMovieViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let movieTitle = movieTitleTextField.text,
              let movieDescribtion = describtionTextField.text else {
            return
        }
        
        if textField == movieTitleTextField {
            viewModel.receiveMovieTitle(title: movieTitle)
        } else if textField == describtionTextField {
            viewModel.receiveMovieDescrption(description: movieDescribtion)
        }

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        movieTitleTextField.resignFirstResponder()
        describtionTextField.resignFirstResponder()
      return true
    }
    
}

//MARK: - UIImagePickerControllerDelegate and UINavigationControllerDelegate
extension AddMovieViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        
        let imageTitle = UUID().uuidString
        movieImageButton.setImage(image, for: .normal)
        image.saveImageToDocumentsDirectory(image: image, withName: imageTitle)
        viewModel.uploadMovieImage(imageTitle: imageTitle)
        
      dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
      dismiss(animated: true, completion: nil)
    }
    
}

//MARK: - AddMovieViewController UI setUp
extension AddMovieViewController {
    
    private func setUpBinders() {
        
        viewModel.buttonValidator.sink { isValid in
            
            self.doneButton.isEnabled = isValid
        }.store(in: &cancellables)
        
        
        
        viewModel.movie.sink { [weak self] movie in
            guard let self,
                  let movie else { return }

            self.movieCompletion?(movie)
        }.store(in: &cancellables)
    }

    private func setUpDelegates() {
        movieTitleTextField.delegate = self
        describtionTextField.delegate = self
        starRaitingView.delegate = self
        imagePicker.delegate = self
    }

    private func gerneViewSetUp() {
        genreView.layer.borderWidth = 3
        genreView.layer.cornerRadius = 20
        genreView.layer.borderColor = CGColor(red: 0.35, green: 0.55, blue: 0.49, alpha: 1.00)
    }
    
    private func setUpDoneButton() {
        doneButton.layer.cornerRadius = 5
        doneButton.layer.masksToBounds = false
        doneButton.layer.shadowRadius = 25.0
        doneButton.layer.shadowOpacity = 0.8
        doneButton.layer.shadowOffset = CGSize.zero
        doneButton.layer.shadowColor = CGColor(red: 0.95, green: 0.10, blue: 0.10, alpha: 1.00)
    }
    
    private func totalGenreCheckHeight() -> CGFloat {
        var height: CGFloat = 0
        for genre in Constants.genreChoseArray {
            let checkbox = CustomCheckBoxView(frame: .zero)
            checkbox.setLabelText(genre)
            height += checkbox.frame.height + 20
        }
        return height
    }
    
    private func addGenreChecks() {
        let totalGenreHeight = totalGenreCheckHeight()
        var xPosition: CGFloat = 0
        var yPosition: CGFloat = 0
        var row = 0
        var currentRowHighestElement: CGFloat = 0

        for genre in Constants.genreChoseArray {
            let checkbox = CustomCheckBoxView(frame: CGRect(x: xPosition, y: yPosition, width: 35, height: 35))
            checkbox.delegate = self
            checkbox.setLabelText(genre)
            
            
            if checkbox.frame.size.height > currentRowHighestElement {
                currentRowHighestElement = checkbox.frame.size.height
            }
            
            if checkbox.frame.width + 40 >= genreCheckView.frame.size.width - xPosition {
                row += 1
                yPosition += currentRowHighestElement + 8
                xPosition = 0
                currentRowHighestElement = 0
            }
            
            checkbox.frame.origin = CGPoint(x: xPosition, y: yPosition + 4)
            genreCheckView.addSubview(checkbox)
            xPosition += checkbox.frame.size.width + 52
        }

        guard totalGenreHeight >= genreCheckView.frame.size.height else { return }
    
        let newHeightConstrain = totalGenreHeight - totalGenreHeight / 3
        contentViewHeight.constant = newHeightConstrain
    }
    
}
