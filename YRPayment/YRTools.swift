//
//  YRTools.swift
//  YRPayment
//
//  Created by Yassir RAMDANI on 6/27/19.
//  Copyright © 2019 Yassir RAMDANI. All rights reserved.
//

import Foundation

extension CGRect {
    static func + (rect: CGRect, i: CGFloat) -> CGRect {
        return CGRect(x: rect.minX - i, y: rect.minY - i, width: rect.width + 2 * i, height: rect.height + 2 * i)
    }
}

extension UILabel {
    func select() {
        layoutIfNeeded()
        let labelBorder = CAShapeLayer()
        labelBorder.path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: frame.width, height: frame.height) + 3, cornerRadius: 8).cgPath
        labelBorder.fillColor = UIColor.clear.cgColor
        labelBorder.strokeColor = UIColor(red: 0.99, green: 0.78, blue: 0.21, alpha: 1.00).cgColor
        labelBorder.lineWidth = 1
        layer.addSublayer(labelBorder)
    }

    func unSelect() {
        layer.sublayers?.removeAll()
    }
}

public enum YRCreditCardType {
    case masterCard
    case custom(UIImage)
}

enum RegisterFontError: Error {
    case invalidFontFile
    case fontPathNotFound
    case initFontError
    case registerFailed
}
class GetBundle {}

extension UIFont {
    static func register(fontUrl: URL?) throws {
        guard let resourceBundleURL = fontUrl else {
            throw RegisterFontError.fontPathNotFound
        }
        guard let fontData = try? Data(contentsOf: resourceBundleURL),
            let dataProvider = CGDataProvider(data: fontData as CFData) else {
            throw RegisterFontError.invalidFontFile
        }
        guard let fontRef = CGFont(dataProvider) else {
            throw RegisterFontError.initFontError
        }
        var errorRef: Unmanaged<CFError>? = nil
        guard CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) else   {
            throw RegisterFontError.registerFailed
        }
    }
}
