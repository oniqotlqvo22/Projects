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
        guard let view = loadViewFromNib(nibName: Constants.popUpViewNibName) else { return }
        view.frame = CGRect(x: Constants.popUpViewFrameX, y: Constants.popUpViewFrameY, width: frame.width, height: frame.height)
        addSubview(view)
        autoDismissTimer = Timer.scheduledTimer(withTimeInterval: Constants.popUpViewDismissTimeInterval, repeats: false, block: { [weak self] _ in
          self?.hide()
        })
        messageLabel.text = messageLabelText
    }
    
    //MARK: - Methods
    private func hide() {
        UIView.animate(withDuration: Constants.popUpViewHideAnimationDuration, animations: {
            self.alpha = Constants.popUpViewHideAnimationAlpha
            self.transform = Constants.popUpViewHideAnimationTransform
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
