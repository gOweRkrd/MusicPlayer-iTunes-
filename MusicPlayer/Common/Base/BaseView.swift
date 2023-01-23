//
//  BaseView.swift
//  MusicPlayer
//
//  Created by Артем Галай on 10.01.23.
//

import UIKit

extension CGFloat {
    static let baseSpacing: CGFloat = 10
    static let baseLightSpacing: CGFloat = 25
    static let baseMediumSpacing: CGFloat = 42
    static let baseLargeSpacing: CGFloat = 54
    static let baseCornerRadius: CGFloat = 10 
}

class BaseView: UIView {

    init() {
        super.init(frame: .zero)
        addSubviews()
        makeConstraints()
        updateConstraints()
        configureView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {}

    func makeConstraints() {}

    func configureView() {
        backgroundColor = UIColor(patternImage: UIImage(named: "backgroundLogIn") ?? UIImage())
    }
}
