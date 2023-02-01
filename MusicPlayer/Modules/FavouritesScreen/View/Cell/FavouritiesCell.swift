import UIKit

protocol FavouritiesCellDelegate: AnyObject {
    func didTapPlayButton(with index: Int?, mode: Int?)
}

final class FavouritiesCell: UITableViewCell {

    weak var delegate: FavouritiesCellDelegate?
    var index: Int?
    private var isFavorite = false

    var data: TrackModel? {
        didSet {
            guard let data = data else { return }
            performerMusicLabelCell.text = data.artistName
            nameMusicLabelCell.text = data.trackName
        }
    }

    // MARK: - UI Elements

    lazy var performerMusicLabelCell: UILabel = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.white.cgColor, UIColor.blue.cgColor]
        let label = UILabel()
        label.font = .interRegular(size: 18)
        label.textAlignment = .right
        label.textColor = .cyan
        return label
    }()

    lazy var nameMusicLabelCell: UILabel = {
        let label = UILabel()
        label.font = .interRegular(size: 16)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()

    lazy var playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(playBut), for: .touchUpInside)
        return button
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSybViewCell()
        setupConstraintsCell()
        contentView.backgroundColor = UIColor(named: "mainColor")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func changeButton() {
        if isFavorite {
            playButton.setImage(UIImage(named: "pause"), for: .normal)
        } else {
            playButton.setImage(UIImage(named: "play"), for: .normal)
        }
    }

    @objc func playBut() {
        isFavorite.toggle()
        changeButton()
        delegate?.didTapPlayButton(with: index, mode: 0)
    }
}

// MARK: - Setup Constrains

extension FavouritiesCell {

    func addSybViewCell() {
        contentView.addSubviews([performerMusicLabelCell, nameMusicLabelCell, playButton])
    }

    func setupConstraintsCell() {

        NSLayoutConstraint.activate([
            performerMusicLabelCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            performerMusicLabelCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            nameMusicLabelCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            nameMusicLabelCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameMusicLabelCell.trailingAnchor.constraint(equalTo: playButton.leadingAnchor),

            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            playButton.heightAnchor.constraint(equalToConstant: 30),
            playButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
