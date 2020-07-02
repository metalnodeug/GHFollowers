//
//  GHFTextField.swift
//  GHFollowers
//
//  Created by metalnodeug on 27/06/2020.
//  Copyright © 2020 metalnodeug. All rights reserved.
//

import UIKit

class GHFTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false

        self.layer.cornerRadius = 10
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.systemGray4.cgColor

        self.textColor = .label
        self.tintColor = .label
        self.textAlignment = .center
        self.font = UIFont.preferredFont(forTextStyle: .title2)
        self.adjustsFontSizeToFitWidth = true
        self.minimumFontSize = 12

        self.backgroundColor = .tertiarySystemBackground
        self.autocorrectionType = .no
        self.placeholder = "Enter a username"
        self.returnKeyType = .go
    }

    func showEmptyInputAnimation() {
        let shake = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = 2
        shake.autoreverses = true

        let fromPoint = CGPoint(x: center.x - 10, y: center.y)
        let fromValue = NSValue(cgPoint: fromPoint)

        let toPoint = CGPoint(x: center.x + 10, y: center.y)
        let toValue = NSValue(cgPoint: toPoint)

        shake.fromValue = fromValue
        shake.toValue = toValue

        let borderColor = CABasicAnimation(keyPath: "borderColor")
        borderColor.duration = 0.4
        borderColor.autoreverses = true
        borderColor.fromValue = layer.borderColor
        borderColor.toValue = UIColor.systemRed.cgColor

        self.layer.add(borderColor, forKey: nil)
        self.layer.add(shake, forKey: nil)
    }
}
