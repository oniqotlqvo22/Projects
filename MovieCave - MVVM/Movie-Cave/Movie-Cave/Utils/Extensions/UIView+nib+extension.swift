//
//  UIView+nib+extension.swift
//  Movie-Cave
//
//  Created by Admin on 29.08.23.
//

import Foundation
import UIKit

extension UIView {
    
    /// Loads a view controller's view from a nib file.
    /// - Parameter nibName: The name of the nib file
    /// - Returns: The view loaded from the nib file
    func loadViewFromNib(nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self).first as? UIView
    }
}
