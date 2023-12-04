//
//  PopUpView.swift
//  MovieCave
//
//  Created by Admin on 27.10.23.
//

import UIKit

class PopUpView: UIView {

    //MARK: - IBOutlets
    @IBOutlet private weak var messageLabel: UILabel!
    
    //MARK: - Properties
    private var autoDismissTimer: Timer?
    
    //MARK: - Intializers
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(frame: CGRect, inVC: UIViewController, messageLabelText: String) {
        super.init(frame: frame)
        guard let view = loadViewFromNib(nibName: "PopUpView") else { return }
        view.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        addSubview(view)
        autoDismissTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { [weak self] _ in
          self?.hide()
        })
        messageLabel.text = messageLabelText
    }
    
    //MARK: - Methods
    private func hide() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        autoDismissTimer?.invalidate()
        hide()
    }
}
