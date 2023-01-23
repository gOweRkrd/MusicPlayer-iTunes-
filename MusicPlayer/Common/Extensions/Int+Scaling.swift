//
//  Int+Scaling.swift
//  MusicPlayer
//
//  Created by Александр Косяков on 10.01.2023.
//

import UIKit

extension Int {

    private var referenceSize: (width: CGFloat, height: CGFloat) { (390, 844) }
    private var screenSize: CGSize { UIScreen.main.bounds.size }

    var halfScreen: CGFloat {
        return CGFloat(screenSize.height / 2.7)
    }

    /// Сделать пропорционально ширине экрана iPhoneX, только если ширина текущего устройства больше ширины iPhoneX.
    var fitWMore: CGFloat {
        let ratio = screenSize.width / referenceSize.width
        return ratio > 1 ? CGFloat(self) * ratio : CGFloat(self)
    }
}
