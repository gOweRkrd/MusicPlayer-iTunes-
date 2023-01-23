//
//  DefaultTextField.swift
//  MusicPlayer
//
//  Created by Артем Галай on 10.01.23.
//

import UIKit

private extension CGFloat {
    static var textPadding: UIEdgeInsets {
        .init(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10
        )
    }
}

final class DefaultTextField: UITextField {

    init(placeholder: String? = nil, isSecureTextEntry: Bool) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.isSecureTextEntry = isSecureTextEntry
        configureTextField()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTextField() {
        textAlignment = .left
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = CGFloat.baseCornerRadius
        clearButtonMode = .whileEditing
        autocorrectionType = .no
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
    }
}

extension DefaultTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: CGFloat.textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: CGFloat.textPadding)
    }
}
