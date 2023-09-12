//
//  File.swift
//  Movie-Cave
//
//  Created by Admin on 10.09.23.
//

import Foundation

extension Array {
    /// This extension adds a subscript to the Array protocol that allows safe access to elements of the collection. It returns an optional element at the specified index, which will be nil if the index is out of bounds.
    /// - Parameters: This subscript takes one parameter: the index of the element to access.
    /// - Returns: This subscript returns an optional element of the collection at the specified index. If the index is out of bounds, nil is returned.
    subscript(from index: Int) -> Element? {
        guard self.count > index,
              index >= 0 else { return nil }
        
        return self[index]
    }
    
}
