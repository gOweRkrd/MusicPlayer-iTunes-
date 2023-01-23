//
//  SelectorCountriesView.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 18.01.2023.
//

import UIKit

protocol SelectorCountriesViewDelegate: AnyObject {
    func didTapCountryButton(_ country: Country)
}

final class SelectorCountriesView: UIView {
    
    weak var delegate: SelectorCountriesViewDelegate?
    
    private var buttons = [CountryButtonView]()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupView()
        addTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews([stackView])
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    private func setupView() {
        let usButton = CountryButtonView(country: .usa)  // USA
        let auButton = CountryButtonView(country: .australia) //Australia
        let gbButton = CountryButtonView(country: .britain) //United Kingdom of Great Britain
        let ruButton = CountryButtonView(country: .russia) //Russia
        let frButton = CountryButtonView(country: .france) //France
        let esButton = CountryButtonView(country: .spain) //Spain
        usButton.didTapButton(true)
        
        buttons = [usButton, auButton, gbButton, ruButton, frButton, esButton]
        stackView.addArrangedSubviews(buttons)
    }
    
    private func addTarget() {
        buttons.forEach { button in
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(_ selector: CountryButtonView) {
        buttons.forEach { $0.didTapButton(false) }
        selector.didTapButton(true)
        delegate?.didTapCountryButton(selector.name)
    }
}
