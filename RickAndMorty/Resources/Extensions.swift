//
//  Extensions.swift
//  RickAndMorty
//
//  Created by Josue Perez  on 4/13/23.
//

import Foundation
import UIKit

extension UIView {
    // UIView custom method that lets us add multiple views at the same time, order matters.
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
}
