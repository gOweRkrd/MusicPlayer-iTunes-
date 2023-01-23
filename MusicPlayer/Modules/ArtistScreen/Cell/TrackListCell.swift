//
//  TrackListCell.swift
//  MusicPlayer
//
//  Created by Дария Григорьева on 18.01.2023.
//

import UIKit

protocol TrackListCellDelegate: AnyObject {
    func didTapPlayButton(with index: Int?)
}

class TrackListCell: UITableViewCell {
    
    weak var delegate: TrackListCellDelegate?
    var index: Int?
    
    private let trackLabel: UILabel = {
        let label = UILabel()
        label.text = "Track"
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 2
        label.font = .interRegular(size: 17)
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(playButtonTap), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(nameTrack: String?, index: Int?) {
        trackLabel.text = nameTrack
        self.index = index
    }
    
    @objc private func playButtonTap(_ sender: UIButton) {
        delegate?.didTapPlayButton(with: index)
    }
    
    private func configure() {
        backgroundColor = .black
        contentView.addSubviews([trackLabel, playButton])
        
        NSLayoutConstraint.activate([
            trackLabel.topAnchor.constraint(equalTo: topAnchor),
            trackLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            trackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .leadingMargin),
            trackLabel.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: .trailingMargin),
            
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: .trailingMargin),
            playButton.heightAnchor.constraint(equalToConstant: .playTrackHeight),
            playButton.widthAnchor.constraint(equalToConstant: .playTrackHeight),
        ])
    }
}

private extension CGFloat {
    static let leadingMargin: CGFloat = 10
    static let trailingMargin: CGFloat = -10
    static let playTrackHeight: CGFloat = 40
}
