//
//  URL+UIimae+Thumbnail.swift
//  Movie-Cave
//
//  Created by Admin on 7.09.23.
//

import Foundation
import UIKit
import AVFoundation

extension URL {
    /// Generates a thumbnail image from the video file specified by the URL.
    /// - Returns: Returns: A UIImage object representing the generated thumbnail image, or nil if an error occurs.
    func generateThumbnail() -> UIImage? {
        do {
            let asset = AVURLAsset(url: self)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imageGenerator.copyCGImage(at: CMTime(value: 26, timescale: 1),
                                                         actualTime: nil)
            
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
}
