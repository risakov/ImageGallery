//
//  String+imageGalleryDateFormat.swift
//  Image gallery
//
//  Created by Narek Matosyan on 18.02.2023.
//

import Foundation


extension String {
    func imageGalleryDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: date ?? Date())
    }
}
