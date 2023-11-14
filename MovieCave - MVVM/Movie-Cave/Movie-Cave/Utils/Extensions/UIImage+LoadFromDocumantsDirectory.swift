//
//  File.swift
//  Movie-Cave
//
//  Created by Admin on 10.09.23.
//

import Foundation
import UIKit

extension UIImage {
    
    /// Saves the input image to the Documents directory with the given name
    /// - Parameters:
    ///   - image: The UIImage to save
    ///   - name: The name to save the image file as (without file extension)
    func saveImageToDocumentsDirectory(image: UIImage, withName name: String) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {

            print("unable to access the Documents directory")
            return
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(name)
        
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {

            print("unable to get image data")
            return
        }
        
        do {
            try imageData.write(to: fileURL)
            print("success saving image")
        } catch {
            print("error savign image")
        }
    }
    
    /// Function is an extension method that allows you to load an image from the Documents directory of your app. Here is a description of the parameters and return value:
    /// - Parameter name: The name of the image file to load from the Documents directory.
    /// - Returns: An optional UIImage object containing the loaded image, or nil if the image couldn't be loaded.
    func loadImageFromDocumentsDirectory(withName name: String) -> UIImage? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Error if unable to access the Documents directory")
            return nil
        }

        let fileURL = documentsDirectory.appendingPathComponent(name)

        if FileManager.default.fileExists(atPath: fileURL.path) {
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
        }

        return nil
    }
    
}
