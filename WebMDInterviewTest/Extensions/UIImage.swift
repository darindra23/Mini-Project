//
//  UIImage.swift
//  WebMDInterviewTest
//
//  Created by darindra.khadifa on 10/09/22.
//

import Foundation
import UIKit

extension UIImage {
    internal func resizeImage(width: CGFloat, height: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}
