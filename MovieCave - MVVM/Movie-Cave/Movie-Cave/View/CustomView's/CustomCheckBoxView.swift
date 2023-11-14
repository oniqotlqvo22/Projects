//
//  CustomCheckBoxView.swift
//  Movie-Cave
//
//  Created by Admin on 8.09.23.
//

import UIKit

//MARK: - CustomCheckBoxViewDelegate
protocol CustomCheckBoxViewDelegate {
    func checkedBox(text: String)
}

class CustomCheckBoxView: UIView {

    //MARK: - Properties
    var delegate: CustomCheckBoxViewDelegate?
    private var isChecked = false
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isHidden = true
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(red: 0.35, green: 0.55, blue: 0.49, alpha: 1.00)
        imageView.image = UIImage(systemName: "checkmark")
        return imageView
    }()
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textColor = UIColor.label
        return label
    }()
    private let boxView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.label.cgColor
        return view
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gasture = UITapGestureRecognizer(target: self, action: #selector(onClick))
        addSubview(label)
        addSubview(boxView)
        addSubview(imageView)
        boxView.addGestureRecognizer(gasture)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        boxView.frame = CGRect(x: 7, y: 7, width: Int(frame.size.width) - 14, height: Int(frame.size.width) - 14)
        imageView.frame = bounds
        label.frame = CGRect(x: boxView.frame.maxX + 4, y: 0, width: 60, height: bounds.height)
    }
    
    //MARK: - Custom Methods
    @objc func onClick() {
        guard let text = label.text else { return }
        isChecked = !isChecked
        delegate?.checkedBox(text: text)
        imageView.isHidden = !isChecked
    }
    
    func setLabelText(_ text: String) {
        label.text = text
    }
}
