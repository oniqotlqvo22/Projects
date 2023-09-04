//
//  UIImage+Resize.swift
//  Movie-Cave
//
//  Created by Admin on 4.09.23.
//

import Foundation
import UIKit

extension UIImage {
    
    func resizeImage(targetSize: CGSize) -> UIImage? {
            let scaledSize = aspectFill(to: targetSize)
            
            UIGraphicsBeginImageContextWithOptions(scaledSize, false, scale)
            draw(in: CGRect(origin: .zero, size: scaledSize))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return newImage
        }
        
        private func aspectFill(to targetSize: CGSize) -> CGSize {
            let widthRatio = targetSize.width / size.width
            let heightRatio = targetSize.height / size.height
            let scaleFactor = max(widthRatio, heightRatio)
            let scaledWidth = size.width * scaleFactor
            let scaledHeight = size.height * scaleFactor
            return CGSize(width: scaledWidth, height: scaledHeight)
        }
    
}
